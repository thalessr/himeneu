class FeatureImagesController < ApplicationController
  before_filter :authenticate_user!

  def new
    @feature_image = FeatureImage.new
  end

  def index
    provider = Provider.select(:id).find_by(slug: params[:provider] )
    @feature_image = FeatureImage.where(provider_id: provider.id)
    respond_to do |format|
      format.html { @feature_image.provider }
      format.json { render json: @feature_image}
    end
  end

  def create
    @feature_image = FeatureImage.new(feature_image_params)
    @feature_image.save
    redirect_to provider_path(@feature_image.provider)
  end

  def destroy
    feature_image = FeatureImage.find(params[:id])
    unless feature_image.blank?
      feature_image.destroy
      # respond_to do |format|
      #   format.html
      #   format.json { head :no_content }
      # end
      redirect_to provider_path(feature_image.provider)
    end
  end

  private

  def feature_image_params
    params.require(:feature_image).permit(:image, :image_cache,:provider_id)
  end


end
