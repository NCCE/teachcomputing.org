class ClassMarker::WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token, :authenticate

  before_action :verify_hmac_signature

  def assessment
    begin
      @user = find_user
      @assessment = find_assessment
      @achievement = find_achievement
      latest_attempt = @user.assessment_attempts.where(assessment_id: @assessment.id).last

      if request[:result][:percentage].to_f >= 65.0
        latest_attempt.transition_to(:complete)
        @achievement.set_to_complete
      else
        latest_attempt.transition_to(:failed)
      end
    rescue StandardError => e
      Raven.capture_exception(e)
      head :ok
    end

    head :ok
  end

  private

    class InvalidHMACError < StandardError
      def initialize
        super 'Invalid HMAC signature'
      end
    end

    def calculate_signature(raw_request)
      secret = ENV.fetch('CLASS_MARKER_WEBHOOK_SECRET_PHRASE')

      digest = OpenSSL::Digest.new('sha256')
      Base64.encode64(OpenSSL::HMAC.digest(digest, secret, raw_request)).strip
    end

    def find_achievement
      @user.achievements.where(activity_id: @assessment.activity.id).first
    end

    def find_assessment
      Assessment.find_by!(class_marker_test_id: request[:test][:test_id])
    end

    def find_user
      User.find_by!(email: request[:result][:email])
    end

    def hmac_header_valid?
      header_val = request.headers['HTTP_X_CLASSMARKER_HMAC_SHA256']
      return false if header_val.blank?

      expected = header_val.split(/,/).first
      actual = calculate_signature(request.raw_post)

      ActiveSupport::SecurityUtils.secure_compare(actual, expected)
    end

    def verify_hmac_signature
      raise InvalidHMACError unless hmac_header_valid?
    end
end
