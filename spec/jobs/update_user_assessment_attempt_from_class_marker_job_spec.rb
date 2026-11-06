require "rails_helper"

RSpec.describe UpdateUserAssessmentAttemptFromClassMarkerJob, type: :job do
  let(:user) { create(:user, email: "john@example.com") }
  let(:activity) { create(:activity) }
  let(:programme) { create(:cs_accelerator) }
  let!(:secondary) { create(:secondary_certificate) }
  let(:achievement) { create(:achievement, user_id: user.id, activity_id: activity.id) }
  let(:assessment) do
    create(:assessment, class_marker_test_id: "100", activity_id: activity.id, programme_id: programme.id)
  end
  let(:assessment_attempt) { create(:assessment_attempt, user_id: user.id, assessment_id: assessment.id) }
  let(:passing_json_body) { File.read("spec/support/class_marker/passing_webhook.json") }
  let(:failed_json_body) { File.read("spec/support/class_marker/failed_webhook.json") }
  let(:passing_result) { JSON.parse(passing_json_body, symbolize_names: true) }

  def perform_passing_job
    UpdateUserAssessmentAttemptFromClassMarkerJob.perform_now(passing_result[:test][:test_id], user.id,
      passing_result[:result][:percentage])
  end

  describe "#perform" do
    context "when the user has passed the test" do
      let!(:user_programme_enrolment) { create(:user_programme_enrolment, user:, programme:) }

      before do
        [user, activity, achievement, assessment, assessment_attempt]
      end

      it "transitions assessment_attempt to complete" do
        UpdateUserAssessmentAttemptFromClassMarkerJob.perform_now(passing_result[:test][:test_id], user.id,
          passing_result[:result][:percentage])
        expect(assessment_attempt.current_state).to eq("passed")
      end

      it "transitions achievement to complete" do
        UpdateUserAssessmentAttemptFromClassMarkerJob.perform_now(passing_result[:test][:test_id], user.id,
          passing_result[:result][:percentage])
        expect(achievement.current_state).to eq("complete")
      end

      it "calls CSAcceleratorEnrolmentTransitionJob job" do
        expect(CSAcceleratorEnrolmentTransitionJob).to receive(:perform_now)

        UpdateUserAssessmentAttemptFromClassMarkerJob.perform_now(passing_result[:test][:test_id], user.id,
          passing_result[:result][:percentage])
      end

      it "uses one certificate number when run twice" do
        perform_passing_job
        perform_passing_job

        expect(user_programme_enrolment.in_state?(:complete)).to be true
        expect(programme.programme_complete_counter.reload.counter).to eq 1
      end

      it "raises an error when the attempt has timed out" do
        assessment_attempt.transition_to(:timed_out)

        expect { perform_passing_job }.to raise_error(Statesman::TransitionFailedError)
      end

      it "retries when the database is temporarily unavailable" do
        allow(Assessment).to receive(:find_by!).and_raise(ActiveRecord::ConnectionNotEstablished)

        expect { perform_passing_job }.to have_enqueued_job(described_class)
      end

      it "retries when the database connection drops mid-query" do
        allow(Assessment).to receive(:find_by!).and_raise(ActiveRecord::ConnectionFailed)

        expect { perform_passing_job }.to have_enqueued_job(described_class)
      end

      context "when the programme is not csa" do
        let(:programme) { create(:programme) }

        it "calls CertificatePendingTransitionJob job" do
          expect(CertificatePendingTransitionJob).to receive(:perform_now)

          UpdateUserAssessmentAttemptFromClassMarkerJob.perform_now(passing_result[:test][:test_id], user.id,
            passing_result[:result][:percentage])
        end
      end

      context "when the programme is a level" do
        let!(:programme) { create(:a_level) }
        let!(:cs_accelerator) { create(:cs_accelerator) }

        it "calls CertificatePendingTransitionJob job" do
          expect(CertificatePendingTransitionJob).to receive(:perform_now)

          UpdateUserAssessmentAttemptFromClassMarkerJob.perform_now(passing_result[:test][:test_id], user.id,
            passing_result[:result][:percentage])
        end

        it "transitions assessment_attempt to complete" do
          UpdateUserAssessmentAttemptFromClassMarkerJob.perform_now(passing_result[:test][:test_id], user.id,
            passing_result[:result][:percentage])
          expect(assessment_attempt.current_state).to eq("passed")
        end

        it "transitions user_programme_enrolment to complete" do
          UpdateUserAssessmentAttemptFromClassMarkerJob.perform_now(passing_result[:test][:test_id], user.id,
            passing_result[:result][:percentage])

          expect(user_programme_enrolment.in_state?(:complete)).to be true
        end
      end
    end

    context "when the user has failed the test" do
      before do
        user
        activity
        achievement
        assessment
        assessment_attempt
        failing_result = JSON.parse(failed_json_body, symbolize_names: true)
        UpdateUserAssessmentAttemptFromClassMarkerJob.perform_now(failing_result[:test][:test_id], user.id,
          failing_result[:result][:percentage])
      end

      it "transitions assessment_attempt to failed" do
        expect(assessment_attempt.current_state).to eq("failed")
      end

      it "leaves achievement in enrolled state" do
        expect(achievement.current_state).to eq("enrolled")
      end
    end

    context "when the user is invalid" do
      it "raises a MissingRecordError for the missing user that Sentry will report" do
        expect {
          UpdateUserAssessmentAttemptFromClassMarkerJob.perform_now(passing_result[:test][:test_id], "missing-user-id",
            passing_result[:result][:percentage])
        }.to raise_error(described_class::MissingRecordError) { |error|
          expect(Sentry.configuration.exception_class_allowed?(error)).to be true
        }
      end
    end

    context "when the assessment is invalid" do
      it "raises a MissingRecordError for the missing assessment that Sentry will report" do
        expect { perform_passing_job }.to raise_error(described_class::MissingRecordError) { |error|
          expect(Sentry.configuration.exception_class_allowed?(error)).to be true
        }
      end
    end

    context "when the achievement is missing" do
      before do
        assessment_attempt
      end

      it "raises a MissingRecordError for the missing achievement that Sentry will report" do
        expect { perform_passing_job }.to raise_error(described_class::MissingRecordError) { |error|
          expect(Sentry.configuration.exception_class_allowed?(error)).to be true
        }
      end
    end

    context "when the assessment_attempt is invalid" do
      before do
        assessment
      end

      it "raises an error" do
        expect { perform_passing_job }.to raise_error(NoMethodError)
      end
    end
  end
end
