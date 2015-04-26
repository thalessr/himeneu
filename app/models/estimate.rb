class Estimate < ActiveRecord::Base

  belongs_to :provider
  belongs_to :customer

  validates_presence_of :provider
  validates_presence_of :customer

  def self.can_write_reponse(customer, provider)
    exists?(response: nil, customer_id: customer.id, provider_id: provider.id)
  end

  def self.get_estimate(customer, provider)
    find_by(response: nil, customer_id: customer.id, provider_id: provider.id)
  end
end
