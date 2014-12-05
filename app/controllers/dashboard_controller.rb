class DashboardController < ApplicationController
	def index
		@user = current_user 
		unless @user.is_completed
			redirect_to new_customer_path
		else
			#redirect users who complted their sign up
		end
		
	end
end
