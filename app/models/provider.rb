class Provider < ActiveRecord::Base
  extend Extra::Selection
  extend CacheRedis::Utils
  include Extra::Methods

	belongs_to :user
	has_many :addresses, dependent: :destroy
  has_many :recommendations, dependent: :destroy
  has_many :customers, through: [:recommendations, :interests]
  has_many :feature_images, inverse_of: :provider, dependent: :destroy
  has_many :interests, dependent: :destroy

  before_save :set_video_url
  before_save :verify_urls
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
        distinct.not_deleted.first_last_name_search(name) | city_name_search(:addresses, name) | profession_search(name)

      elsif search_params[:profession] && search_params[:city].blank?
        name = search_params[:name]
        profession = search_params[:profession]
        distinct.not_deleted.first_last_name_search(name).profession_search(profession)

      elsif search_params[:city]
        name = search_params[:name]
        profession = search_params[:profession]
        city = search_params[:city]
        distinct.not_deleted.first_last_name_search(name).city_name_search(:addresses, city).profession_search(profession)
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

  def verify_urls
    self.facebook = add_url_protocol(facebook) if facebook_changed? && !facebook.blank?
    self.twitter = add_url_protocol(twitter)  if twitter_changed? && !twitter.blank?
    self.instagram = add_url_protocol(instagram)  if instagram_changed? && !instagram.blank?
    self.website = add_url_protocol(website)  if website_changed? && !website.blank?
  end

  def add_url_protocol(url)
     /^http/i.match(url) ? url : "http://#{url}"
  end

  def self.autocomplete_seed
      $redis.set "autocomplete", ActsAsTaggableOn::Tag.most_used(10).pluck(:name).to_json
  end

  def self.get_autocomplete
    JSON.parse($redis.get("autocomplete"))
  end

  def self.carousel
    carousel = get_redis_value("carousel")
    if carousel.blank?
      carousel = Provider.select(:first_name, :last_name, :image).where.not(image: nil).recent(5)
      unless carousel.blank?
        set_redis_key("carousel" , carousel.to_json, 8)
        carousel = get_redis_value("carousel")
      end
    end
    carousel
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
