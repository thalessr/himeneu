class ProvidersController < ApplicationController
  def index
    @providers = Provider.all
  end

  def new
    @provider = Provider.new
    @provider.addresses.build
  end

  def create
    @provider = current_user.providers.build(provider_params)
    if @provider.save
      current_user.set_completed
      redirect_to @provider
    else
      render :new
    end
  end

  def edit
    @provider = Provider.find(params[:id])
  end

  def update
    @provider = Provider.find(params[:id])
    if @provider.update_attributes(provider_params)
      redirect_to @provider
    else
      render :edit
    end
  end

  def destroy
    @provider = Provider.find(params[:id])
    @provider.destroy
    redirect_to new_provider_path
  end

  def show
    @provider = Provider.find(params[:id])
  end

  private
  def provider_params
    params.require(:provider).permit(
                                      :first_name, :last_name, :age, :contact,
                                      :image, :profession, :city, :experience,
                                      addresses_attributes: [:id, :city, :zipcode, :_destroy]
                                      )
  end
end
