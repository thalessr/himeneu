class InterestsController < ApplicationController

	def create
    if current_user.is_customer?
      interest = current_user.customer.interests.build(interest_params)
      interest.provider = Provider.friendly.find(interest_params[:provider_id])
      if interest.save
        send_email(interest)
        redirect_to provider_path(interest.provider)
        flash[:notice] = "Aguarde o contato deste prestador de serviço!"
      end
    end
	end

	private
		def interest_params
  		params.permit(:customer_id, :provider_id)
		end

    def send_email(interest)
     if Rails.env.production?
        ProviderMailer.delay.interested_email(interest.customer, interest.provider)
      else
        ProviderMailer.interested_email(interest.customer, interest.provider).deliver
      end
    end

end
