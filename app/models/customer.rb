class Customer < ActiveRecord::Base
	belongs_to :user
	#include all required fields here
	validates_presence_of :first_name

	def set_completed
		user = User.find(self.user_id)
		user.is_completed = true
		user.save
	end
end
