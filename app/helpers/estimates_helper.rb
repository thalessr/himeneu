module EstimatesHelper
  def verify_estimate(customer, provider)
    if current_user.is_provider?
      Estimate.can_write_reponse(customer, current_user.provider)
    else
      false
    end
  end
end
