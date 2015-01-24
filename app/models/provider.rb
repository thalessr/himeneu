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
    process_in_background :image

    #Tags
    acts_as_taggable
    acts_as_taggable_on :profession


    def full_name
    	"#{first_name} #{last_name}"
    end

    def score
        total = (self.recommendations.sum(:rating)/self.recommendations.count)
        total
    end

    def self.recent(number)
        if number
            limit(number).reverse_order
        else
            none
        end
    end

end
