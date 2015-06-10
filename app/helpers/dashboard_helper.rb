module DashboardHelper
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def providers_count
    Provider.count("providers.id")
  end

  def customers_count
    Customer.count("customers.id")
  end

  def users_count
    User.count("users.id")
  end

end
