class InterestsController < ApplicationController

	def create
    if current_user.is_customer?
      interest = current_user.customer.interests.build(interest_params)
      interest.provider = Provider.friendly.find(interest_params[:provider_id])
      if interest.save
        #use mailer here
        redirect_to provider_path(interest.provider)
        flash[:notice] = "Aguarde o contato deste prestador de serviço!"
      end
    end
	end

	private
		def interest_params
  		params.permit(:customer_id, :provider_id)
		end

end
