class ProvidersController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :authenticate_user!, :except => [:carousel, :show]

  def index
    # @providers = Provider.recent(5)
  end

  def search
    @providers = Provider.not_deleted
    .order(order_param)
    .paginate(:page => params[:page], :per_page => 6)
    .includes(:profession)
    .search(params[:q])


    respond_to do |format|
      format.html{ @providers}
      format.json{ render json: {items: @providers}} unless @providers.try(:total_pages)
      format.json{render json:{
                    total_entries: @providers.total_entries,
                    current_page: @providers.current_page,
                    next_page: @providers.next_page,
                    previous_page: @providers.previous_page,
                    total_pages: @providers.total_pages,
                    per_page: @providers.per_page,
                    items: @providers
                  }
                  }
    end
  end

  def new
    @provider = Provider.new
  end

  def create
    @provider = current_user.build_provider(provider_params)
    respond_to do |format|
      if @provider.save
        current_user.set_completed(2)
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
    if current_user
      @provider = Provider.friendly.find(params[:id])
    else
      @provider = Provider.friendly.find(params[:id])
    end
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
        format.json { render json: @provider.errors,  status: :unprocessable_entry}
      end
    end
  end

  def destroy
    @provider = Provider.friendly.find(params[:id])
    @provider.delete
    redirect_to provider_path(@provider)
  end

  def recover
    @provider = Provider.friendly.find(params[:id])
    @provider.recover
    redirect_to provider_path(@provider)
  end

  def carousel
    providers = Provider.carousel
    respond_to do |format|
      format.html{ providers}
      format.json{ render json: providers}
    end
  end

  def cloud
    tags = Provider.cloud
    respond_to do |format|
      format.html{ tags}
      format.json{ render json: tags}
    end
  end

  def bestSeller
    providers = Provider.includes(:profession).best_sellers
    respond_to do |format|
      format.html{ providers }
      format.json{ render json: providers}
    end
  end

  private
  def provider_params
    params.require(:provider).permit(
      :first_name, :last_name, :age,
      :image, :image_cache,:profession_list, :instagram, :website, :twitter,
      :video_url, :facebook,:city, :experience, :tag_list,
      addresses_attributes: [:id, :city, :zipcode, :email, :phone, :_destroy]
    )
  end

  def order_param
    order = params[:sort]
    unless order.blank?
      if order.include? "Asc"
        order = "first_name ASC"
      elsif order.include? "Desc"
        order = "first_name DESC"
      else
        order = "score DESC"
      end
    else
      order = "id"
    end
  end
end
