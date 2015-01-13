module ApplicationHelper
	def redirect_to_edit
		if current_user.is_customer?
		   customer = Customer.find_by_user_id(current_user.id)
		   if customer
	           edit_customer_path(customer.id)
           end
		elsif current_user.is_provider?
		   provider = Provider.find_by_user_id(current_user.id)
		   if provider
	           edit_provider_path(provider.id)
           end
		end
	end
end
