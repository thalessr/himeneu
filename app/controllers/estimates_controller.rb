class EstimatesController < ApplicationController

  def new
    @estimate = Estimate.new
  end

  def create
    if current_user.is_customer?
      estimate = current_user.customer.estimates.build(estimate_params)
      estimate.provider = Provider.friendly.find(estimate_params[:provider_id])
      respond_to do |format|
        if estimate.save
          next_state(estimate)
          # TODO: send email to provider and change the state to the next
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

  def next_state(estimate)
    interest = Interest.find_by(customer_id: estimate.customer, provider_id: estimate.provider)
    interest.move_2_next
    interest.delete_cached_state
  end

end
