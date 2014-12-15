class DashboardController < ApplicationController
	before_filter :authenticate_user!, :except => [:index]

	def index
		if current_user
			@user = current_user
			unless @user.is_completed
				redirect_to new_customer_path
			else
				#redirect users who complted their sign up
				
		    end
		else

		end
		
	end
end
