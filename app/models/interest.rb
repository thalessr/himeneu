class Interest < ActiveRecord::Base
  belongs_to :provider
  belongs_to :customer

  state_machine :initial => :interested do

    event :negotiate do
      transition :interested => :negotiating
    end

    event :hire do
      transition :negotiating => :hired
    end

    event :review do
      transition :hired => :reviewing
    end

    event :complete do
      transition :reviewing => :completed
    end
  end

  def self.has_interest?(user, provider)
    if user.is_customer?
      customer = Customer.select(:id).find_by(user_id: user.id)
      Interest.exists?(customer_id: customer.id , provider_id: provider.id)
    else
      false
    end
  end

  def self.next_state(user, provider)
    customer = Customer.select(:id).find_by(user_id: user.id)
    interest = Interest.find_by(customer_id: customer.id, provider_id: provider.id)
    states = interest.state_paths.events
    if states.length >= 1
      states[0]
    end
  end
end
