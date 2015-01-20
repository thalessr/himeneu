class CustomersController < ApplicationController
	load_and_authorize_resource
	skip_authorize_resource :only => [:new, :create]

	def index
		@customers = Customer.all.where(user_id: current_user.id)
	end

	def show_all
		@customers = Customer.all
	end

	def new
		@customer = Customer.new
		@customer.build_address
	end

	def create
		@customer = current_user.customers.build(customer_params)
		if @customer.save
			current_user.set_completed
			redirect_to @customer
		else
			render :new
		end
	end

	def show
		@customer = Customer.includes(:address).find(params[:id])
		@customer.get_wedding_date
	end

	def edit
		@customer = Customer.includes(:address).find(params[:id])
	    @customer.build_address
		@customer.get_wedding_date
	end

	def update
		@customer = Customer.find(params[:id])
		if @customer.update_attributes(customer_params)
			redirect_to @customer
		else
			render :edit
		end
	end

	private
	def customer_params
		params.require(:customer).permit(
				                             :first_name, :last_name,
				                             :age, :key, :wedding_date, :image,
				                             address_attributes: [:id, :city, :zipcode, :email, :phone, :_destroy]
				                        )
	end
end
