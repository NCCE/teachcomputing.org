class ApiController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }
  skip_before_action :authenticate
  before_action :authenticate_api

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def authenticate_api
    authenticate_or_request_with_http_token do |token, _options|
      ActiveSupport::SecurityUtils.secure_compare(token, ENV.fetch("USER_ACHIEVEMENTS_API_SECRET"))
    end
  end

  def render_not_found_response(exception)
    render json: {error: exception.message}, status: :not_found
  end
end
