module AuthorizationHelper

  def can_read_providers?
    can_read?
  end

  # This method refers to edit and destroy
  def can_manage_provider?(provider)
    if current_user.is_provider?
      current_user.provider.id == provider.id
    end
  end

  def can_read_customers?
    unless current_user.nil?
      can_read? && current_user.is_provider?
    end
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
