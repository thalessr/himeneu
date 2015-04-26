class Customer < ActiveRecord::Base
  extend Extra::Selection
  include Extra::Methods

  belongs_to :user
  belongs_to :address, dependent: :destroy

  has_many :providers, through: [:interests, :estimates]

  delegate :city, :zipcode, :email, :phone, :longitude, :latitude, to: :address
  delegate :email, to: :user
  # before_save :set_wedding_date
  #include all required fields here
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :age
  validates_presence_of :wedding_date

  accepts_nested_attributes_for :address, :allow_destroy => true


  #CarrierWave
  mount_uploader :image, ImageUploader
  process_in_background :image if Rails.env.production?

  #Friendly_id
  extend FriendlyId
  friendly_id :slug_options, use: :slugged

  def get_wedding_date
    self.wedding_date = self.wedding_date.strftime('%d/%m/%Y') if self.wedding_date
  end


  def as_json(options = {})
    super(options.merge(include: {:address => {:only => [:city] }}))
  end

  def self.search(query)
    if query.blank?
      where(nil)
    else
      name = "%#{query.downcase}%"
      distinct.first_last_name_search(name) | city_name_search(:address, name)
    end
  end


  private
  def set_wedding_date
    self.wedding_date = self.wedding_date.strftime('%m-%d-%Y') if self.wedding_date
  end

end
