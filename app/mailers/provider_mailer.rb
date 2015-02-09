class ProviderMailer < ActionMailer::Base
  default from: "no-reply@himeneu.com"

  def interested_email(customer, provider)
    @provider = provider
    @customer = customer
    @url  = customer_url(@customer)
    mail(to: @provider.email, subject: I18n.t(:someone_interested))
  end

end
