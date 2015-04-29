class ApplicationController < ActionController::Base
   # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :current_ability
  before_action :set_locale #, :authenticate_user!



  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  rescue_from CanCan::AccessDenied do |exception|
  	render :file => "#{Rails.root}/public/404", :layout => false, :status => :not_found
  end

  def current_ability
  	@current_ability ||= Ability.new(current_user) unless current_user.nil?
  end


end
