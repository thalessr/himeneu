class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_locale #, :authenticate_user!



  def set_locale
    I18n.locale = locale_from_http_header || I18n.default_locale
  end

  ##
  # Getting default locale from web browser
  ##
  def locale_from_http_header
    language = request.env['HTTP_ACCEPT_LANGUAGE']
    unless language.blank?
      http_locale = language.scan(/^[a-z]{2}-[A-Z]{2}/)
      unless http_locale.blank?
        http_locale = http_locale.first
      else
        http_locale = language.scan(/^[a-z]{2}/).first
      end
    end
  end

  end
