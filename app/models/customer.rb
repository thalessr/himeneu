class Customer < ActiveRecord::Base
	belongs_to :user

	def set_completed
		user = User.find(self.user_id)
		user.is_completed = true
		user.save
	end
end
