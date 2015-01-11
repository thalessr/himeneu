class ProvidersController < ApplicationController
  def index
    @providers = Provider.all
  end

  def new
    @provider = Provider.new
  end

  def create
    @provider = current_user.providers.build(provider_params)
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

  def edit
    @provider = Provider.find(params[:id])
  end

  def update
    @provider = Provider.find(params[:id])
    respond_to do |format|
      if @provider.update_attributes(provider_params)
        response.headers['X-Flash-Notice'] = 'Atualizado com sucesso.'
        format.html  { redirect_to @provider_ur}
        format.json  { render :json => @provider, location: @provider, notice: 'Printer was successfully created.' }
      else
        format.html { render :edit }
        format.json { render json: @provider.errors, status: :unprocessable_entry}
      end
    end
  end

  def destroy
    @provider = Provider.find(params[:id])
    @provider.destroy
    redirect_to new_provider_path
  end

  def show
    @provider = Provider.includes(:addresses).find(params[:id])
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
