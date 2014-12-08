class Customer < ActiveRecord::Base
	belongs_to :user
	#include all required fields here
	validates_presence_of :first_name
	validates_presence_of :last_name
	validates_presence_of :age
	validates_presence_of :wedding_date

	def set_completed
		user = User.find(self.user_id)
		user.is_completed = true
		user.save
	end
end
