module InterestsHelper
  def has_interest?(provider)
    Interest.has_interest?(current_user, provider)
  end

  def next_state_action(provider)
    state = Interest.next_state(current_user, provider)
    if state == "negotiate".to_sym
      link_to I18n.t(:estimate), "#estimatesModal", :class=>"btn btn-primary", :id => 'estimate'
    else
      button_to I18n.t("state_machine.#{state}"),
      {
        :controller => "interests",
        :action => "change_state",
        :provider_id => @provider.slug,
        :user_id => current_user.id,
        :state => state
      }, :class => 'btn btn-primary', :id => 'interest' ,:method=> :post,  :disabled => (state == "completed"),
        'data-original-title'.to_sym => t("state_machine.#{state}_hint"), "data-toggle".to_sym => "tooltip"
    end
  end

  def get_interest(user)
    if current_user.is_customer?
      Interest.get_interest(current_user.customer, user)
    elsif current_user.is_provider?
      Interest.get_interest(user, current_user.provider)
    end
  end
end
