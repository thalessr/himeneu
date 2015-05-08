class DashboardController < ApplicationController
	before_filter :authenticate_user!, :except => [:index,:privacy]

	def index
    if current_user
      @user = current_user
      unless @user.is_completed?
        redirect_to decision_dashboard_index_path
      else
        redirect_to providers_path
      end
    end
	end

	def privacy
	end

  def decision
   @customer = Customer.new
   @customer.build_address
   @provider = Provider.new
   @provider.addresses.build
  end

  def save_decision

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
			redirect_to providers_path
		else
			redirect_to new_provider_path
		end
	end


end
