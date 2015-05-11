class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  api_providers = %w[facebook google_oauth2]

  # def facebook
  #   @user = User.from_omniauth(request.env["omniauth.auth"])

  #   if @user.persisted?
  #     sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
  #     set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
  #   else
  #     session["devise.facebook_data"] = request.env["omniauth.auth"]
  #     redirect_to new_user_registration_url
  #   end
  # end

  # def twitter
  #   @user = User.from_omniauth(request.env["omniauth.auth"])

  #   if @user.persisted?
  #     sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
  #     set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
  #   else
  #     session["devise.facebook_data"] = request.env["omniauth.auth"]
  #     redirect_to new_user_registration_url
  #   end
  # end
  self.class_eval do
    api_providers.each do |name|
      define_method(name) do

        @user = User.from_omniauth(request.env["omniauth.auth"])

        if @user.persisted?
          @customer = Customer.new
          @customer.build_address
          @provider = Provider.new
          @provider.addresses.build
          sign_in_and_redirect @user, :event => :authentication
          set_flash_message(:notice, :success, :kind => name.capitalize ) if is_navigational_format?
        else
          if name == "twitter"
            session["devise.auth_data"] = request.env["omniauth.auth"].except("raw_info","extra")
          else
            session["devise.auth_data"] = request.env["omniauth.auth"]
          end
          redirect_to new_user_registration_url
        end

      end
    end
  end

end
