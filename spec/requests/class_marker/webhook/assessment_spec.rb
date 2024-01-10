require "rails_helper"

RSpec.describe ClassMarker::WebhooksController do
  let(:passing_json_body) { File.read("spec/support/class_marker/passing_webhook.json") }

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

    context "with an invalid webhook signature" do
      it "raises an error" do
        expect do
          post class_marker_assessment_webhook_path, params: JSON.parse(passing_json_body)
        end.to raise_error(StandardError, /Invalid HMAC signature/)
      end
    end
  end
end
