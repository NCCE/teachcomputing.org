require 'rails_helper'

RSpec.describe ClassMarker::WebhooksController do
  let(:user) { create(:user, email: 'john@example.com') }
  let(:activity) { create(:activity) }
  let(:achievement) { create(:achievement, user_id: user.id, activity_id: activity.id) }
  let(:assessment) { create(:assessment, class_marker_test_id: '100', activity_id: activity.id) }
  let(:assessment_attempt) { create(:assessment_attempt, user_id: user.id, assessment_id: assessment.id) }
  let(:passing_json_body) { File.read('spec/support/class_marker/passing_webhook.json') }
  let(:failed_json_body) { File.read('spec/support/class_marker/failed_webhook.json') }

  describe '#assessment' do
    context 'with a passing webhook' do
      before do
        [user, activity, achievement, assessment, assessment_attempt]

        allow_any_instance_of(described_class)
          .to receive(:verify_hmac_signature).and_return(true)
        post class_marker_assessment_webhook_path, params: JSON.parse(passing_json_body)
      end

      it 'transitions to complete' do
      end
    end

    context 'with a failing webhook' do
      before do
        [user, activity, achievement, assessment, assessment_attempt]

        allow_any_instance_of(described_class)
          .to receive(:verify_hmac_signature).and_return(true)
        post class_marker_assessment_webhook_path, params: JSON.parse(failed_json_body)
      end

      it 'transitions to failed' do
      end
    end

    context 'with a incorrect data' do
      it 'gets rescued' do
      end
    end
  end
end
