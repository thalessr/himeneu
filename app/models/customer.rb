class Customer < ActiveRecord::Base
	belongs_to :user
	belongs_to :address, dependent: :destroy
	has_many :recommendations, dependent: :destroy

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
  process_in_background :image

	def get_wedding_date
		self.wedding_date = self.wedding_date.strftime('%d/%m/%Y') if self.wedding_date
	end

	def full_name
		"#{self.first_name} #{self.last_name}"
	end

    private
	def set_wedding_date
		self.wedding_date = self.wedding_date.strftime('%m-%d-%Y') if self.wedding_date
	end

end
