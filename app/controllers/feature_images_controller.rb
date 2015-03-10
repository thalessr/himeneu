require 'pry'
class FeatureImagesController < ApplicationController

  def create
    binding.pry
    @feature_image = FeatureImage.new(interest_params)
    @feature_image.save
    binding.pry
    redirect_to provider_path(interest_params["provider_id"])
  end

  private

  def interest_params
    params.permit(:image, :provider_id)
  end


end
