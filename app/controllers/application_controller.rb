class ApplicationController < ActionController::Base
  include AuthenticationHelper

  before_action :authenticate

  def authenticate
    return unless ENV['BASIC_AUTH_PASSWORD']

    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['BASIC_AUTH_USER'] && password == ENV['BASIC_AUTH_PASSWORD']
    end
  end

  def authenticate_user!
    redirect_to(helpers.create_account_url) unless current_user
  end

  def redirect_to_dashboard
    redirect_to dashboard_path if current_user
  end

  def redirect_back_or(default)
    forwarding_url = session[:forwarding_url]
    session.delete(:forwarding_url)
    redirect_to(forwarding_url || default)
  end

  def store_internal_location
    session[:forwarding_url] = request.original_fullpath if request.get?
  end
end
