require "rails_helper"

RSpec.describe ClassMarker::WebhooksController do
  let(:passing_json_body) { File.read("spec/support/class_marker/passing_webhook.json") }
  let(:missing_params_json_body) { File.read("spec/support/class_marker/missing_params_webhook.json") }

  describe "#assessment" do
    context "with a valid webhook signature" do
      before do
        allow_any_instance_of(described_class)
          .to receive(:verify_hmac_signature).and_return(true)
      end

      it "queues UpdateUserAssessmentAttemptFromClassMarkerJob job" do
        expect do
          post class_marker_assessment_webhook_path, params: JSON.parse(passing_json_body)
        end.to have_enqueued_job(UpdateUserAssessmentAttemptFromClassMarkerJob)
      end

      it "queues job with correct params" do
        expect do
          post class_marker_assessment_webhook_path, params: JSON.parse(passing_json_body)
        end.to have_enqueued_job.with("100", "123456", "75.0")
      end

      it "returns 200 response" do
        post class_marker_assessment_webhook_path, params: JSON.parse(passing_json_body)
        expect(response.status).to eq(200)
      end
    end

    context "with missing params" do
      before do
        allow_any_instance_of(described_class)
          .to receive(:verify_hmac_signature).and_return(true)
      end

      it "returns 400 bad request response" do
        post class_marker_assessment_webhook_path, params: JSON.parse(missing_params_json_body)
        expect(response.status).to eq(400)
      end

      it "raises a sentry error" do
        allow(Sentry).to receive(:capture_message)

        post class_marker_assessment_webhook_path, params: JSON.parse(missing_params_json_body)
        expect(Sentry).to have_received(:capture_message)
      end
    end

    context "with an invalid webhook signature" do
      before do
        allow_any_instance_of(described_class)
          .to receive(:hmac_header_valid?).and_return(false)
      end

      it "raises InvalidHMACError" do
        expect do
          post class_marker_assessment_webhook_path, params: JSON.parse(passing_json_body)
        end.to raise_error(ClassMarker::WebhooksController::InvalidHMACError, "Invalid HMAC signature")
      end
    end
  end

  describe "private methods" do
    let(:controller_instance) { described_class.new }
    let(:secret) { "test_secret" }
    let(:signature) { "valid_signature" }

    before do
      allow(ENV).to receive(:fetch).and_return(secret)
      allow(controller_instance).to receive(:request).and_return(OpenStruct.new(headers: {"HTTP_X_CLASSMARKER_HMAC_SHA256" => signature}))
    end

    describe "#calculate_signature" do
      it "calculates the correct HMAC signature" do
        expected_signature = Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest.new("sha256"), secret, passing_json_body)).strip
        calculated_signature = controller_instance.send(:calculate_signature, passing_json_body)
        expect(calculated_signature).to eq(expected_signature)
      end
    end

    describe "#hmac_header_valid?" do
      context "when the header is present" do
        it "returns true if the HMAC signature is valid" do
          allow(controller_instance).to receive(:calculate_signature).and_return(signature)
          expect(controller_instance.send(:hmac_header_valid?)).to be true
        end

        it "returns false if the HMAC signature is invalid" do
          allow(controller_instance).to receive(:calculate_signature).and_return("invalid_signature")
          expect(controller_instance.send(:hmac_header_valid?)).to be false
        end
      end

      context "when the header is absent" do
        before do
          allow(controller_instance.request).to receive(:headers).and_return({})
        end

        it "returns false" do
          expect(controller_instance.send(:hmac_header_valid?)).to be false
        end
      end
    end
  end
end
