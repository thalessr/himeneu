module InterestsHelper
  def has_interest?(provider)
    Interest.has_interest?(current_user, provider)
  end
end
