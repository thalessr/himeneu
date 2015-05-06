class Estimate < ActiveRecord::Base

  belongs_to :provider
  belongs_to :customer

  validates_presence_of :provider
  validates_presence_of :customer

  #
  # A provider only can write a reponse when a customer send to them an estimate question.
  # In that way, customers must do the first contact and the provider will answer only once.
  #
  def self.can_write_reponse(customer, provider)
    exists?(response: nil, customer_id: customer.id, provider_id: provider.id)
  end

  def self.get_estimate(customer, provider)
    find_by(response: nil, customer_id: customer.id, provider_id: provider.id)
  end
end
