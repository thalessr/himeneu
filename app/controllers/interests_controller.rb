class InterestsController < ApplicationController
  before_filter :authenticate_user!

	def create
    if current_user.is_customer?
      interest = current_user.customer.interests.build(interest_params)
      interest.provider = Provider.friendly.find(interest_params[:provider_id])
      if interest.save
        send_email(interest)
        interest.delete_cached_state
        redirect_to provider_path(interest.provider)
        flash[:notice] = "Aguarde o contato deste prestador de serviço!"
      end
    end
	end

  def change_state
    provider = Provider.friendly.select(:id).find(params[:provider_id])
    interest = Interest.find_by(customer_id: current_user.customer.id , provider_id: provider.id)
    interest.send(params[:state])
    interest.delete_cached_state
    flash[:notice] = "Aguarde o contato deste prestador de serviço!"
    redirect_to provider_path(interest.provider)
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
