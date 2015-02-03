class InterestsController < ApplicationController

	def create
	  @interest = Interest.new(interest_params)
	end

	private
  		def interest_params
    		params.require(:interest).permit(:customer_id, :provider_id)
  		end

end
