require 'rails_helper'

RSpec.describe FailedAssessmentEmailJob, type: :job do
  let(:user) { create(:user) }
  let(:assessment_attempt) { create(:assessment_attempt, user_id: user.id) }

  describe '#perform' do
    before do
      ExpireAssessmentAttemptJob.perform_now(assessment_attempt)
    end

    context 'when the attempt is in a state of failed' do
      it 'sends an email' do
        expect { FailedAssessmentEmailJob.perform_now(assessment_attempt) }
          .to change { ActionMailer::Base.deliveries.count }.by(1)
      end
    end
  end
end
