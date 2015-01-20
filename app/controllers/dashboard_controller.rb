class DashboardController < ApplicationController
	before_filter :authenticate_user!, :except => [:index]

	def index
		if current_user
			@user = current_user
			unless @user.is_completed
				if @user.is_customer?
					redirect_to new_customer_path
				elsif @user.is_provider?
					redirect_to new_provider_path
				end
			else
				#redirect users who complted their sign up
				if @user.is_provider?
					customers_path
				end

		    end
		else

		end

	end
end
