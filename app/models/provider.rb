 class Provider < ActiveRecord::Base
	belongs_to :user
	has_many :addresses, dependent: :destroy
    has_many :recommendations, dependent: :destroy
    has_many :customers, through: :recommendations

	validates_presence_of :first_name
	validates_presence_of :last_name
	validates_presence_of :age

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


    def full_name
    	"#{first_name} #{last_name}"
    end

   def slug_options
    [
      :first_name,
      [:first_name, :last_name],
      [:first_name, :age, :last_name]
    ]
   end

    def self.recent(number)
        if number
            limit(number).reverse_order
        else
            none
        end
    end

    def self.search(query)
      if query.blank?
        where(nil)
      else
        q = "%#{query}%"
        distinct.joins(:addresses).where("first_name like ? or addresses.city like ? ", q, q)
      end
    end

    def self.autocomplet_seed
        $redis.set "autocomplete", ActsAsTaggableOn::Tag.most_used(10).pluck(:name).to_json
    end

end
