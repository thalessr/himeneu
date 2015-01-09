class CustomersController < ApplicationController

	def index
		@customers = Customer.all.where(user_id: current_user.id)
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
		@customer = Customer.find(params[:id])
		@customer.get_wedding_date
	end

	def edit
		@customer = Customer.find(params[:id])
		@customer.get_wedding_date
	end

	def update
		@customer = Customer.find(params[:id])

		if @customer.update_attributes(customer_params)
			# if @customer.image_processed
			   redirect_to @customer
		    # else
			    # render :edit
			# end
		else
			render :edit
		end
	end

	private
	def customer_params
		params.require(:customer).permit(
				                             :first_name, :last_name,
				                             :age, :key, :wedding_date, :image,
				                             address_attributes: [:id, :city, :zipcode, :_destroy]
				                        )
	end
end
