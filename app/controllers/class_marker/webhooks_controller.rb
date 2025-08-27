class ClassMarker::WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token, :authenticate


  def assessment
    test_id = params.dig(:test, :test_id)
    cm_user_id = params.dig(:result, :cm_user_id)
    percentage = params.dig(:result, :percentage)

    if test_id.blank? || cm_user_id.blank? || percentage.blank?
      Sentry.capture_message("Classmarker webhook missing parameters", extra: {received_params: params.to_unsafe_h})
      head :bad_request
      return
    end

    UpdateUserAssessmentAttemptFromClassMarkerJob.perform_later(test_id, cm_user_id, percentage)
    head :ok
  end

  private

  class InvalidHMACError < StandardError
    def initialize
      super("Invalid HMAC signature")
    end
  end

  def calculate_signature(raw_request)
    secret = ENV.fetch("CLASS_MARKER_WEBHOOK_SECRET_PHRASE")

    digest = OpenSSL::Digest.new("sha256")
    Base64.encode64(OpenSSL::HMAC.digest(digest, secret, raw_request)).strip
  end

  def hmac_header_valid?
    header_val = request.headers["HTTP_X_CLASSMARKER_HMAC_SHA256"]
    return false if header_val.blank?

    expected = header_val.split(",").first
    actual = calculate_signature(request.raw_post)

    ActiveSupport::SecurityUtils.secure_compare(actual, expected)
  end

  def verify_hmac_signature
    raise InvalidHMACError unless hmac_header_valid?
  end
end
