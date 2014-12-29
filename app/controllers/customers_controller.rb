class CustomersController < ApplicationController

	def index
		@customers = Customer.all.where(user_id: current_user.id)
	end

	def new
		@customer = Customer.new
	end

	def create
		@customer = current_user.customers.build(customer_params)
		if @customer.save
			@customer.set_completed
			redirect_to @customer
		else
			render :new
		end
	end

	def show
		@customer = Customer.find_by_user_id(current_user.id)
		@customer.get_wedding_date
	end

	def edit
		@customer = Customer.find_by_user_id(current_user.id)
		@customer.get_wedding_date
	end

	def update
		@customer = Customer.find_by_user_id(current_user.id)
		if @customer.update_attributes(customer_params)
			redirect_to @customer
		else
			render :edit
		end
	end

	private 
	def customer_params
		params.require(:customer).permit(:first_name, :last_name, :age, :wedding_date)
	end
end
