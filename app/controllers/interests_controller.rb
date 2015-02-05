class InterestsController < ApplicationController

	def create
	  @interest = Interest.new(interest_params)
	  @interest.save
	  redirect_to provider_path(interest_params[:provider_id])
	  flash[:notice] = "Aguarde o contato deste prestadore de serviço!"
	end

	private
  		def interest_params
    		params.permit(:customer_id, :provider_id)
  		end

end
