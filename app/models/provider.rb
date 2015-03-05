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
      search_params = query_2_hash(query)

      if search_params[:name] && search_params[:profession].blank?
        name = search_params[:name]
        distinct.first_last_name_search(name) | city_name_search(:addresses, name) | profession_search(name)

      elsif search_params[:profession] && search_params[:city].blank?
        name = search_params[:name]
        profession = search_params[:profession]
        distinct.first_last_name_search(name).profession_search(profession)

      elsif search_params[:city]
        name = search_params[:name]
        profession = search_params[:profession]
        city = search_params[:city]
        distinct.first_last_name_search(name).city_name_search(:addresses, city).profession_search(profession)
      end

    end
  end

  def self.profession_search(profession)
    self.tagged_with(profession.remove('%'), :any => true)
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

  private
    def self.query_2_hash(query)
      hash = Hash.new
      array = query.split(',')
      hash[:name] = "%#{array[0].strip.downcase}%" unless array[0].blank?
      hash[:profession] = "#{array[1].strip}" unless array[1].blank?
      hash[:city] = "#{array[2].strip.downcase}" unless array[2].blank?
      hash
    end

end
