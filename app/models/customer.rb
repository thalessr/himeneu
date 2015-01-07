class Customer < ActiveRecord::Base
	belongs_to :user
	before_save :set_wedding_date
	#include all required fields here
	validates_presence_of :first_name
	validates_presence_of :last_name
	validates_presence_of :age
	validates_presence_of :wedding_date

    #CarrierWave
    mount_uploader :image, ImageUploader
    after_save :enqueue_image


	def get_wedding_date
		self.wedding_date = self.wedding_date.strftime('%m-%d-%Y') if self.wedding_date
	end

    private
	def set_wedding_date
		self.wedding_date = self.wedding_date.strftime('%d/%m/%Y') if self.wedding_date
	end

	def enqueue_image
        unless self.key.include? "${filename}"
		    ImageWorker.perform_async(self.id, self.key) if key.present?
		end
	end


	class ImageWorker
	    include Sidekiq::Worker
	    sidekiq_options :queue => :carrierwave

		    def perform(id, key)
		      customer = Customer.find(id)
		      customer.key = key
		      customer.remote_image_url = customer.image.direct_fog_url(with_path: true)
		      customer.update_column(:image_processed, true)
		      customer.save
		      customer.image.recreate_versions!
		    end
	end
end
