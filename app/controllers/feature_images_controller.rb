class FeatureImagesController < ApplicationController

  def create
    @feature_image = FeatureImage.new(feature_image_params)
    @feature_image.save
    redirect_to provider_path(@feature_image.provider)
  end

  def destroy
     feature_image = FeatureImage.find(params[:id])
     unless feature_image.blank?
      feature_image.destroy
      redirect_to provider_path(feature_image.provider)
     end
  end

  private

  def feature_image_params
    params.require(:feature_image).permit(:image, :provider_id)
  end


end
