class DashboardController < ApplicationController
	before_filter :authenticate_user!, :except => [:index,:privacy]

	def index
		if current_user
			@user = current_user
      customer_redirect(@user) if @user.is_customer?
      provider_redirect(@user) if @user.is_provider?
  		redirect_to new_user_registration_path if @user.roles.empty?
		end
	end

	def privacy
	end

	private
	def customer_redirect(user)
		if user.is_completed?
			redirect_to providers_path
		else
			redirect_to new_customer_path
		end
	end

	def provider_redirect(user)
		if user.is_completed?
			redirect_to customers_path
		else
			redirect_to new_provider_path
		end
	end


end
