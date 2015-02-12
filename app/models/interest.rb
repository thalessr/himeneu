class Interest < ActiveRecord::Base
	belongs_to :provider
  belongs_to :customer

  def self.has_interest?(user, provider)
    if user.is_customer?
      customer = Customer.find_by(user_id: user.id)
      Interest.exists?(customer_id: customer.id , provider_id: provider.id)
    else
      false
    end
  end
end
