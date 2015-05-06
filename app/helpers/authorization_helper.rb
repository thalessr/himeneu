module AuthorizationHelper

  def can_read_providers?
    can_read?
  end

  # This method refers to edit and destroy
  # It verify if the current_user is "themself"
  def can_manage_provider?(provider)
    if current_user.is_provider?
      current_user.provider.id == provider.id
    end
  end

  def is_provider?
    current_user.is_provider?
  end

  def can_read_customers?
    unless current_user.nil?
      can_read? && current_user.is_provider?
    end
  end

  def can_manage_customer?(customer)
    if current_user.is_customer?
      current_user.customer.id = customer.id
    end
  end

  def is_customer?
    current_user.is_customer?
  end

  private
  # The requirements to display the pages are:
  #  - the user must have an active session;
  #  - should completed their account;
  #  - shoud not desactiveted their profile;
  def can_read?
    !current_user.nil? && current_user.is_completed?
  end
end
