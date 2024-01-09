module Dynamics
  class WebhooksController < ApplicationController
    skip_before_action :verify_authenticity_token, :authenticate
    before_action :verify_bearer_token

    def user
      stem_achiever_contact_no = request[:stem_achiever_contact_no]&.downcase
      user = User.find_by(stem_achiever_contact_no:)

      Sentry.capture_message("Dynamics webhook failed as no user found with contact_no: #{stem_achiever_contact_no || "nil"}") unless user

      Achiever::FetchUsersCompletedCoursesFromAchieverJob.perform_later(user) if user

      head :ok
    end

    private

    def verify_bearer_token
      authenticate_or_request_with_http_token do |token, _options|
        ActiveSupport::SecurityUtils.secure_compare(token, ENV.fetch("DYNAMICS_WEBHOOK_TOKEN"))
      end
    end
  end
end
