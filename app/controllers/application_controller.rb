class ApplicationController < ActionController::Base
  include AuthenticationHelper

  before_action :authenticate
  before_action :certification_enabled?

  def authenticate
    return unless ENV['BASIC_AUTH_PASSWORD']

    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['BASIC_AUTH_USER'] && password == ENV['BASIC_AUTH_PASSWORD']
    end
  end

  def certification_enabled?
    ActiveModel::Type::Boolean.new.cast(ENV.fetch('CERTIFICATION_ENABLED'))
  end

  def authenticate_user!
    redirect_to(login_path) unless current_user
  end

  def redirect_to_dashboard
    redirect_to dashboard_path if current_user
  end
end
