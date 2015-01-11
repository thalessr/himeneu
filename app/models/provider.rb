 class Provider < ActiveRecord::Base
	belongs_to :user
	has_many :addresses

	accepts_nested_attributes_for :addresses, :reject_if => :all_blank, :allow_destroy => true

	#CarrierWave
    mount_uploader :image, ImageUploader
    process_in_background :image

end
