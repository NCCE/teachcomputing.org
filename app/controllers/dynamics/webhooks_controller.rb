module Dynamics
  class WebhooksController < ApplicationController
    skip_before_action :verify_authenticity_token, :authenticate
    before_action :verify_bearer_token

    def user
      user = User.find_by(stem_achiever_contact_no: request[:stem_achiever_contact_no])
      Rails.logger.warn request[:stem_achiever_contact_no]
      Rails.logger.warn request.headers.env.reject { |key| key.to_s.include?('.') }
      Achiever::FetchUsersCompletedCoursesFromAchieverJob.perform_later(user) if user

      head :ok
    end

    private

    def verify_bearer_token
      authenticate_or_request_with_http_token do |token, _options|
        ActiveSupport::SecurityUtils.secure_compare(token, ENV.fetch('DYNAMICS_WEBHOOK_TOKEN'))
      end
    end
  end
end
