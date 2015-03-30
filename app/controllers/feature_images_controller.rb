require 'pry'
class FeatureImagesController < ApplicationController

  def create
    @feature_image = FeatureImage.new(interest_params)
    @feature_image.save
    redirect_to provider_path(interest_params["provider_id"])
  end

  private

  def interest_params
    params.require(:feature_image).permit(:image, :provider_id)
  end


end
