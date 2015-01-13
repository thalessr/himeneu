class RegistrationsController < Devise::RegistrationsController
 private
  def sign_up_params
    params.require(:user).permit(:role, :email, :password, :password_confirmation, :role_ids  )
  end

  def account_update_params
    params.require(:user).permit(:role, :email, :password, :password_confirmation, :current_password, :role_ids )
  end
end
