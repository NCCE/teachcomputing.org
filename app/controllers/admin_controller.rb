class AdminController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }
  skip_before_action :authenticate
  before_action :authenticate_api

  def authenticate_api
    authenticate_or_request_with_http_token do |token, _options|
      ActiveSupport::SecurityUtils.secure_compare(token, ENV.fetch('USER_ACHIEVEMENTS_API_SECRET'))
    end
  end
end
