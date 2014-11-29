class DashboardController < ApplicationController
	def index
		user = current_user
		# if user.role == User::ROLES[1].to_s
		# 	redirect_to new_customer_path
		# end
	end
end
