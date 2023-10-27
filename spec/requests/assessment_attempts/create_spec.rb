require 'rails_helper'

RSpec.describe AssessmentAttemptsController do
  let!(:user) { create(:user) }
  let!(:assessment) { create(:assessment) }

  describe 'POST #create' do
    before do
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
    end

    context 'with valid params' do
      it 'creates an assessment attempt record' do
        post assessment_attempts_path(
          assessment_attempt: { assessment_id: assessment.id, user_id: user.id, accepted_conditions: true }
        )
        expect(AssessmentAttempt.where(assessment_id: assessment.id, user_id: user.id).exists?).to be true
      end

      it 'redirects to the assessment link path' do
        post assessment_attempts_path(
          assessment_attempt: { assessment_id: assessment.id, user_id: user.id, accepted_conditions: true }
        )
        expect(response).to redirect_to("#{assessment.link}&cm_e=#{user.email}&cm_user_id=#{user.id}")
      end

      it 'queues ExpireAssessmentAttemptJob job' do
        expect do
          post assessment_attempts_path(
            assessment_attempt: { assessment_id: assessment.id, user_id: user.id, accepted_conditions: true }
          )
        end.to have_enqueued_job(ExpireAssessmentAttemptJob)
      end

      it 'doesn\'t store trn if not present' do
        post assessment_attempts_path(
          assessment_attempt: { assessment_id: assessment.id, user_id: user.id, accepted_conditions: true }
        )
        expect(user.teacher_reference_number).to be_nil
      end

      it 'stores the trn if it is present' do
        path = assessment_attempts_path(
          assessment_attempt: { assessment_id: assessment.id, user_id: user.id, accepted_conditions: true }
        )
        post path, params: {
          user: { teacher_reference_number: 'abc123' },
          accepted_conditions: true
        }
        expect(user.teacher_reference_number).to eq('abc123')
      end

      context 'if the achievement fails to save' do
        it 'should add a flash error' do
          allow_any_instance_of(Achievement).to receive(:save).and_return(false)
          allow_any_instance_of(Programme).to receive(:path).and_return(a_level_path)

          post assessment_attempts_path(
            assessment_attempt: { assessment_id: assessment.id, user_id: user.id, accepted_conditions: true }
          )

          expect(flash[:error]).to be_present
        end
      end

      context 'if the assessment_attempt fails to save' do
        it 'should add a flash error' do
          allow_any_instance_of(AssessmentAttempt).to receive(:save).and_return(false)
          allow_any_instance_of(Programme).to receive(:path).and_return(a_level_path)

          post assessment_attempts_path(
            assessment_attempt: { assessment_id: assessment.id, user_id: user.id, accepted_conditions: true }
          )

          expect(flash[:error]).to be_present
        end
      end
    end

    context 'with invalid params' do
      it 'raises ActiveRecord::RecordNotFound exception' do
        expect do
          post assessment_attempts_path(assessment_attempt: { assessment_id: nil, user_id: nil })
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
