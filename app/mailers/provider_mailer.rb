class ProviderMailer < ActionMailer::Base
  default from: "info@himeneu.com"

  def interested_email(customer, provider)
    @provider = provider
    @customer = customer
    @url  = customer_url(@customer)
    mail(to: @provider.email, subject: I18n.t(:someone_interested))
  end

  def estimate_email(estimate)
    @provider = estimate.provider
    @customer = estimate.customer
    @url  = customer_url(@customer)
    @description = estimate.description
    mail(to: @provider.email, subject: I18n.t(:someone_interested))
  end

  def estimate_response_email(estimate)
    @provider = estimate.provider
    @customer = estimate.customer
    @description = estimate.response
    mail(to: @customer.email, subject: I18n.t(:estimate_reponse))
  end

end
