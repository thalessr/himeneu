class RecommendationsController < ApplicationController
	before_filter :authenticate_user!

	def index
		@recommendations = Recommendation.includes(:customer).where(provider_id: params[:id])
		render json: @recommendations
	end

	def create
		@customer = current_user.customer
		@recommendation = @customer.recommendations.build(recommendation_params)
		@recommendation.provider_id = params[:id]
		respond_to do |format|
			if @recommendation.save
				# format.html { redirect_to provider_path(@recommendation.provider_id)}
				format.json { render :json => @recommendation, status: 200}
			else
	      format.json { render json: @recommendation.errors, status: :unprocessable_entry}
			end
		end
	end

	private
	def recommendation_params
		params.require(:recommendation).permit(:title, :comment, :rating)
	end
end
