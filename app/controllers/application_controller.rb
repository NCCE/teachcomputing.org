class ApplicationController < ActionController::Base
  before_action :authenticate

  def authenticate
    return unless ENV['BASIC_AUTH_PASSWORD']
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['BASIC_AUTH_PASSWORD'] && password == ENV['BASIC_AUTH_PASSWORD']
    end
  end
end
