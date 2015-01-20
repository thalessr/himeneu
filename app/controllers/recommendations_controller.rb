class RecommendationsController < ApplicationController

	def create
		@customer = current_user.customers.first
		@recommendation = @customer.recommendations.build(recommendation_params)
		@recommendation.provider_id = params[:provider_id]
		if @recommendation.save
			redirect_to provider_path(@recommendation.provider_id)
		else
            flash[:alert] = "Erro ao criar recomedação"
		end
	end

	private
	def recommendation_params
		params.require(:recommendation).permit(:title, :comment, :rating)
	end
end
