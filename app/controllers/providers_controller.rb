class ProvidersController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :authenticate_user!, :except => [:carousel]
  load_and_authorize_resource

  def index
    # @providers = Provider.recent(5)
  end

  def search
     @providers = Provider.includes(:addresses, :profession).search(params[:q])
     respond_to do |format|
      format.html{ @providers}
      format.json{ render json: @providers}
     end
  end

  def new
    @provider = Provider.new
  end

  def create
    @provider = current_user.build_provider(provider_params)
    respond_to do |format|
      if @provider.save
        current_user.set_completed
        response.headers['X-Flash-Notice'] = 'Criado com sucesso.'
        format.html { redirect_to @provider}
        format.json { render :json => @provider, status: :created, location: @provider }
      else
        format.html { render :new }
        format.json { render json: @provider.errors, status: :unprocessable_entry}
      end
    end
  end

  def show
    @provider = Provider.includes(:addresses).friendly.find(params[:id])
  end

  def edit
    @provider = Provider.includes(:addresses).friendly.find(params[:id])
  end

  def update
    @provider = Provider.friendly.find(params[:id])
    respond_to do |format|
      if @provider.update_attributes(provider_params)
        response.headers['X-Flash-Notice'] = 'Atualizado com sucesso.'
        format.html  { redirect_to @provider}
        format.json  { render :json => @provider, location: @provider }
      else
        format.html { render :edit }
        format.json { render json: @provider.errors}
      end
    end
  end

  def destroy
    @provider = Provider.friendly.find(params[:id])
    @provider.destroy
    redirect_to new_provider_path
  end

  def carousel
    providers = Provider.select(:first_name, :last_name, :image).recent(5)
    respond_to do |format|
      format.html{ providers}
      format.json{ render json: providers}
     end
  end

  private
  def provider_params
    params.require(:provider).permit(
                                      :first_name, :last_name, :age,
                                      :image, :profession_list, :city, :experience, :tag_list,
                                      addresses_attributes: [:id, :city, :zipcode, :email, :phone, :_destroy]
                                      )
  end
end
