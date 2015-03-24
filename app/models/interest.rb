class Interest < ActiveRecord::Base
  extend CacheRedis::Utils

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
    unless interest.state_paths.empty?
      states = interest.state_paths.events
      if states.length >= 1
        states[0]
      end
    else
      interest.state
    end
  end

  def self.get_interest(customer, provider)
    interest = get_redis_value("interest_#{customer.id}_#{provider.id}")
    if interest.blank?
      interest = Interest.select(:state).find_by(customer_id: customer.id, provider_id: provider.id)
      unless interest.blank?
        set_redis_key("interest_#{customer.id}_#{provider.id}" , interest.state.to_json)
        interest = get_redis_value("interest_#{customer.id}_#{provider.id}")
      end
    end
    interest
  end

  def delete_cached_state
    CacheRedis::Utils.del_key("interest_#{self.customer_id}_#{self.provider_id}")
  end
end
