class DashboardController < ApplicationController
	def index
		@user = current_user 
		unless @user.is_completed
			if @user.role == User::ROLES[1].to_s
				redirect_to new_customer_path
			end
		else
			
		end
		
	end
end
