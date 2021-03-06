class CustomersController < ApplicationController
  before_filter :authenticate_user!

  def index
    # @customers = Customer.all.where(user_id: current_user.id)
  end

  def show_all
    @customers = Customer.all
  end

  def search
    @customers = Customer.not_deleted.order(wedding_date: :asc).paginate(:page => params[:page], :per_page => 5).search(params[:q])
    respond_to do |format|
      format.html{ @customers}
      format.json{ render json: {items: @customers}} unless @customers.try(:total_pages)
      format.json{render json:{
                    total_entries: @customers.total_entries,
                    current_page: @customers.current_page,
                    next_page: @customers.next_page,
                    previous_page: @customers.previous_page,
                    total_pages: @customers.total_pages,
                    per_page: @customers.per_page,
                    items: @customers
                  }
                  }
    end
  end

  def new
    @customer = Customer.new
    @customer.build_address
  end

  def create
    @customer = current_user.build_customer(customer_params)
    if @customer.save
      current_user.set_completed(1)
      redirect_to @customer
    else
      render :new
    end
  end

  # def show
  #   @customer = Customer.includes(:address).friendly.find(params[:id])
  #   @customer.get_wedding_date
  #   respond_to do |format|
  #     format.json { render json: @customer }
  #     format.html
  #   end
  # end

  ### SUBSTITUIR ANTES DE PUSHAR

  def show
    @customer = Customer.friendly.find(params[:id])
    # @customer.get_wedding_date
    respond_to do |format|
      format.json { render json: @customer }
      format.html
    end
  end

  def edit
    @customer = Customer.friendly.find(params[:id])
    @customer.get_wedding_date
  end

  def update
    @customer = Customer.friendly.find(params[:id])
    if @customer.update_attributes(customer_params)
      redirect_to @customer
    else
      render :edit
    end
  end

  def destroy
    @customer = Customer.friendly.find(params[:id])
    @customer.delete
    redirect_to customer_path(@customer)
  end

  def recover
    @customer = Customer.friendly.find(params[:id])
    @customer.recover
    redirect_to customer_path(@customer)
  end

  private
  def customer_params
    params.require(:customer).permit(
      :first_name, :last_name,
      :age, :key, :wedding_date, :image, :image_cache,
      address_attributes: [:id, :city, :zipcode, :state, :country, :email, :phone, :_destroy]
    )
  end
end
