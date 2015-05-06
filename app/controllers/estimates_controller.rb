class EstimatesController < ApplicationController
  before_filter :authenticate_user!

  def new
    @estimate = Estimate.new
  end

  def create
    if current_user.is_customer?
      estimate = current_user.customer.estimates.build(estimate_params)
      estimate.provider = Provider.friendly.find(estimate_params[:provider_id])
      respond_to do |format|
        if estimate.save
          send_email(estimate)
          format.html { redirect_to provider_path(estimate.provider_id)}
          format.json { render :json => estimate, status: :created}
        else
          format.json { render json: estimate.errors, status: :unprocessable_entry}
        end
      end
    end

  end

  def update
    if current_user.is_provider?
      customer = Customer.friendly.find(estimate_params[:customer_id])
      estimate = Estimate.get_estimate(customer, current_user.provider)
      respond_to do |format|
        if estimate.update_attribute(:response, estimate_params[:response])
          send_response_email(estimate)
          format.html { redirect_to provider_path(estimate.provider_id)}
          format.json { render :json => estimate, status: :created}
        else
          format.json { render json: estimate.errors, status: :unprocessable_entry}
        end
      end
    end
  end

  def destroy
  end

  private
  def estimate_params
    params.require(:estimate).permit(:description, :response, :provider_id, :customer_id)
  end

  # def next_state(estimate)
  #   interest = Interest.find_by(customer_id: estimate.customer, provider_id: estimate.provider)
  #   interest.move_2_next
  #   interest.delete_cached_state
  # end

  def send_email(estimate)
    if Rails.env.production?
      ProviderMailer.delay.estimate_email(estimate)
    else
      ProviderMailer.estimate_email(estimate).deliver
    end
  end

  def send_response_email(estimate)
    if Rails.env.production?
      ProviderMailer.delay.estimate_response_email(estimate)
    else
      ProviderMailer.estimate_response_email(estimate).deliver
    end
  end

end
