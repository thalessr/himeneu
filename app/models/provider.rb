 class Provider < ActiveRecord::Base
	belongs_to :user
	has_many :addresses, dependent: :destroy
  has_many :recommendations, dependent: :destroy
  has_many :customers, through: [:recommendations, :interests]
  has_many :interests


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

    def contact
      phones = ""
      if self.addresses.any?
        phones = self.addresses.pluck(:phone).join(",")
      end
      phones
    end

    def self.search(query)
      if query.blank?
        where(nil)
      else
        array = query.split(',')
        if array.length == 1
          name = "%#{array[0].downcase}%"
          distinct.joins(:addresses).where("LOWER(first_name) LIKE ? or LOWER(last_name) LIKE ? OR LOWER(addresses.city) LIKE ? ", name, name, name)
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

    def self.autocomplet_seed
        $redis.set "autocomplete", ActsAsTaggableOn::Tag.most_used(10).pluck(:name).to_json
    end

end
