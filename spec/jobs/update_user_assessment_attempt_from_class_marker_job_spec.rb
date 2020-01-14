require 'rails_helper'

RSpec.describe UpdateUserAssessmentAttemptFromClassMarkerJob, type: :job do
  let(:user) { create(:user, email: 'john@example.com') }
  let(:activity) { create(:activity) }
  let(:programme) { create(:programme) }
  let(:achievement) { create(:achievement, user_id: user.id, activity_id: activity.id) }
  let(:assessment) { create(:assessment, class_marker_test_id: '100', activity_id: activity.id, programme_id: programme.id) }
  let(:assessment_attempt) { create(:assessment_attempt, user_id: user.id, assessment_id: assessment.id) }
  let(:programme_complete_counter) { create(:programme_complete_counter, programme_id: programme.id)}
  let(:passing_json_body) { File.read('spec/support/class_marker/passing_webhook.json') }
  let(:failed_json_body) { File.read('spec/support/class_marker/failed_webhook.json') }
  let(:passing_result) { JSON.parse(passing_json_body, symbolize_names: true) }

  describe '#perform' do
    context 'when the user has passed the test' do
      before do
        [user, activity, achievement, assessment, assessment_attempt, programme_complete_counter]
      end

      it 'transitions assessment_attempt to complete' do
        UpdateUserAssessmentAttemptFromClassMarkerJob.perform_now(passing_result[:test][:test_id], user.id, passing_result[:result][:percentage])
        expect(assessment_attempt.current_state).to eq('passed')
      end

      it 'transitions achievement to complete' do
        UpdateUserAssessmentAttemptFromClassMarkerJob.perform_now(passing_result[:test][:test_id], user.id, passing_result[:result][:percentage])
        expect(achievement.current_state).to eq('complete')
      end

      it 'queues CsAcceleratorEnrolmentTransitionJob job' do
        expect do
          UpdateUserAssessmentAttemptFromClassMarkerJob.perform_now(passing_result[:test][:test_id], user.id, passing_result[:result][:percentage])
        end.to have_enqueued_job(CsAcceleratorEnrolmentTransitionJob)
      end
    end

    context 'when the user has failed the test' do
      before do
        [user, activity, achievement, assessment, assessment_attempt]
        failing_result = JSON.parse(failed_json_body, symbolize_names: true)
        UpdateUserAssessmentAttemptFromClassMarkerJob.perform_now(failing_result[:test][:test_id], user.id, failing_result[:result][:percentage])
      end

      it 'transitions assessment_attempt to failed' do
        expect(assessment_attempt.current_state).to eq('failed')
      end

      it 'leaves achievement in enrolled state' do
        expect(achievement.current_state).to eq('enrolled')
      end
    end

    context 'when the user is invalid' do
      before do
        allow(Raven).to receive(:capture_exception)
        UpdateUserAssessmentAttemptFromClassMarkerJob.perform_now(passing_result[:test][:test_id], user.id, passing_result[:result][:percentage])
      end

      it 'raises an error' do
        expect(Raven).to have_received(:capture_exception).with(an_instance_of(ActiveRecord::RecordNotFound))
      end
    end

    context 'when the assessment is invalid' do
      before do
        user
        allow(Raven).to receive(:capture_exception)
        UpdateUserAssessmentAttemptFromClassMarkerJob.perform_now(passing_result[:test][:test_id], user.id, passing_result[:result][:percentage])
      end

      it 'raises an error' do
        expect(Raven).to have_received(:capture_exception).with(an_instance_of(ActiveRecord::RecordNotFound))
      end
    end

    context 'when the assessment_attempt is invalid' do
      before do
        user
        assessment
        allow(Raven).to receive(:capture_exception)
        UpdateUserAssessmentAttemptFromClassMarkerJob.perform_now(passing_result[:test][:test_id], user.id, passing_result[:result][:percentage])
      end

      it 'raises an error' do
        expect(Raven).to have_received(:capture_exception).with(an_instance_of(NoMethodError))
      end
    end
  end
end
