class CustomersController < ApplicationController

	def index
		@customers = Customer.all.where(user_id: current_user.id)
	end

	def new
		@customer = Customer.new
		@uploader = Customer.new.image
		@customer.build_address
        # @uploader.success_action_redirect = new_customer_url
	end

	def create
		@customer = current_user.customers.build(customer_params)
		@customer.key = params[:key]
		 binding.pry
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
		@uploader = @customer.image
        @uploader.success_action_redirect = edit_customer_url(@customer.id)
	end

	def edit
		@customer = Customer.find(params[:id])
		@customer.get_wedding_date
		@customer.update_attribute(:key, params[:key])
	end

	def update
		@customer = Customer.find(params[:id])

		if @customer.update_attributes(customer_params)
			if @customer.image_processed
			   redirect_to @customer
		    else
			    render :edit
			end
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
