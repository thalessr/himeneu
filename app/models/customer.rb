class Customer < ActiveRecord::Base
	belongs_to :user
	before_save :set_wedding_date
	#include all required fields here
	validates_presence_of :first_name
	validates_presence_of :last_name
	validates_presence_of :age
	validates_presence_of :wedding_date

	def get_wedding_date
		self.wedding_date = self.wedding_date.strftime('%d/%m/%Y') if self.wedding_date 
	end
    
    private
	def set_wedding_date
		self.wedding_date = self.wedding_date.strftime('%Y-%d-%m')
	end
end
