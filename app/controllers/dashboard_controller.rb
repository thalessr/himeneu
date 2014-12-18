class DashboardController < ApplicationController
	before_filter :authenticate_user!, :except => [:index]

	def index
		if current_user
			binding.pry
			@user = current_user
			unless @user.is_completed
				binding.pry
				if @user.is_customer?
					redirect_to new_customer_path
				else
					redirect_to new_provider_path
				end
			else
				#redirect users who complted their sign up
				
		    end
		else

		end
		
	end
end
