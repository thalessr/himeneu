module InterestsHelper
  def has_interest?(provider)
    Interest.has_interest?(current_user, provider)
  end

  def next_state_action(provider)
    state = Interest.next_state(current_user, provider)
    button_to I18n.t(state.to_sym),
        {
           :controller => "interests",
           :action => "change_state",
           :provider_id => @provider.slug,
           :user_id => current_user.id,
           :state => state
        }, :class => 'btn btn-primary', :method=> :post
  end
end
