class Provider < ActiveRecord::Base
  extend Extra::Selection
  include Extra::Methods

	belongs_to :user
	has_many :addresses, dependent: :destroy
  has_many :recommendations, dependent: :destroy
  has_many :customers, through: [:recommendations, :interests]
  has_many :interests

  before_save :set_video_url
  after_save :insert_contact


	validates_presence_of :first_name

  delegate :email, to: :user

	accepts_nested_attributes_for :addresses, :reject_if => :all_blank, :allow_destroy => true

  #CarrierWave
  mount_uploader :image, ImageUploader
  process_in_background :image if Rails.env.production?

  #Tags
  acts_as_taggable
  acts_as_taggable_on :profession

  #Friendly_id
  extend FriendlyId
  friendly_id :slug_options, use: :slugged


  def insert_contact
    if self.addresses.any? && self.contact.nil?
      phones = self.addresses.pluck(:phone).join(",")
      self.update_attribute(:contact, phones)
    end
  end

  def self.search(query)
    if query.blank?
      where(nil)
    else
      array = query.split(',')
      if array.length == 1
        name = "%#{array[0].downcase}%"
        distinct.joins(:addresses, :profession).where("LOWER(first_name) LIKE ? OR LOWER(last_name) LIKE ?
                                                       OR LOWER(addresses.city) LIKE ? " , name, name, name) | self.tagged_with(name.remove('%'), :any => true)
      elsif array.length == 2
        name = "%#{array[0].downcase}%"
        profession = "#{array[1]}"
        distinct.where(" LOWER(first_name) LIKE ? or LOWER(last_name) LIKE ? ", name, name) | self.tagged_with(profession)
      elsif array.length == 3
        name = "%#{array[0].downcase}%"
        profession = "#{array[1]}"
        city = "#{array[2].downcase}"
        distinct.joins(:addresses).tagged_with(profession).where("LOWER(first_name) LIKE ? OR LOWER(last_name) LIKE ? OR LOWER(addresses.city) LIKE ? ", name, name, city) |
        self.tagged_with(profession, :any => true)
      end
    end
  end

  def set_video_url
   unless self.video_url.blank?
     result = /(youtu\.be\/|youtube\.com\/(watch\?(.*&)?v=|(embed|v)\/))([^\?&"'>]+)/.match(self.video_url)
     self.video_url = "http://www.youtube.com/v/#{result[5]}"
   end
  end

  def self.autocomplete_seed
      $redis.set "autocomplete", ActsAsTaggableOn::Tag.most_used(10).pluck(:name).to_json
  end

  def self.get_autocomplete
    JSON.parse($redis.get("autocomplete"))
  end

end
