class ProvidersController < ApplicationController
  def index
    @providers = Provider.all
  end

  def new
    @provider = Provider.new
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
    @provider = Provider.find_by_user_id(current_user.id)
  end

  def update
    @provider = Provider.find_by_user_id(current_user.id)
    if @provider.update_attributes(provider_params)
    else
      render :edit
    end
  end

  def destroy
  end

  def show
    @provider = Provider.find_by_user_id(current_user.id)
  end

  private 
  def provider_params
    params.require(:provider).permit!
  end
end
