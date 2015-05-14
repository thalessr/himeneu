class Estimate < ActiveRecord::Base
  include ActionView::Helpers::SanitizeHelper

  belongs_to :provider
  belongs_to :customer

  validates_presence_of :provider
  validates_presence_of :customer

  before_save :remove_html_tags

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

  #Needs improvement
  def remove_html_tags
    self.description = strip_tags(self.description)
    self.response    = strip_tags(self.response)
  end
end
