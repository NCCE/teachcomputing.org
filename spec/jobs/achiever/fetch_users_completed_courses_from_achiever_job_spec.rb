require "rails_helper"

RSpec.describe Achiever::FetchUsersCompletedCoursesFromAchieverJob, type: :job do
  subject(:perform_job) { described_class.perform_now(user) }

  let(:user) { create(:user) }
  let(:activity_one) { create(:activity, stem_course_template_no: "92f4f86e-0237-4ecc-a905-2f6c62d6b5ae") }
  let(:activity_two) { create(:activity, stem_course_template_no: "92f4f86e-0237-4ecc-a905-2f6c62d6b511") }
  let(:achievement) { create(:achievement, activity_id: activity_one.id, user_id: user.id) }
  let(:achievement_two) { create(:achievement, activity_id: activity_two.id, user_id: user.id) }

  before do
    # Issue with in-build argument checker in rpsec - https://github.com/rspec/rspec/issues/104
    # Disabled argument checker in this test
    RSpec::Mocks.configuration.verify_partial_doubles = false
    stub_attendance_sets
    stub_delegate
  end

  after do
    RSpec::Mocks.configuration.verify_partial_doubles = true
  end

  describe "#perform" do
    include ActiveJob::TestHelper
    context "when a matching activity exists" do
      before do
        programme = create(:primary_certificate)
        create(:programme_activity, programme_id: programme.id, activity_id: activity_one.id)
      end

      after do
        clear_enqueued_jobs
      end

      it "queues CertificatePendingTransitionJob job for complete courses" do
        perform_job
        expect(CertificatePendingTransitionJob).to have_been_enqueued.exactly(:once).with(user, {source: "FetchUsersCompletedCoursesFromAchieverJob"})
      end

      it "queues AutoEnrolJob" do
        perform_job
        expect(AutoEnrolJob).to have_been_enqueued.exactly(:once)
      end

      it "creates an achievement that belongs to the right activity" do
        perform_job
        expect(Achievement.where(activity_id: activity_one.id).exists?).to eq true
      end

      it "creates an achievement that belongs to the right user" do
        perform_job
        expect(Achievement.where(activity_id: activity_one.id, user_id: user.id).exists?).to eq true
      end

      it "sets the correct complete state when the course is fully attended" do
        perform_job

        achievement = Achievement.where(activity_id: activity_one.id, user_id: user.id).first
        expect(achievement.current_state).to eq "complete"
      end

      it "has the state of enrolled when the course is not fully attended" do
        unattended_activity = create(:activity, stem_course_template_no: "92f4f86e-0237-4ecc-a905-2f6c62d6b5ax")
        perform_job
        achievement = Achievement.where(activity_id: unattended_activity.id, user_id: user.id).first
        expect(achievement.current_state).to eq "enrolled"
      end

      it "has the state of dropped when the course progress is cancelled" do
        cancelled_activity = create(:activity, stem_course_template_no: "92f4f86e-0237-4ecc-a905-2f6c62d6b511")
        perform_job
        achievement = Achievement.where(activity_id: cancelled_activity.id, user_id: user.id).first
        expect(achievement.current_state).to eq "dropped"
      end

      context "when an an achievement already exits" do
        it "sets the state to complete if it is fully attended" do
          activity_three = create(:activity, stem_course_template_no: "92f4f86e-0237-4ecc-a905-2f6c62d6b5aw")
          achievement = create(:achievement, activity_id: activity_three.id, user_id: user.id)
          expect { perform_job }.to change { achievement.reload.current_state }.to("complete")
        end
      end
    end

    context "with subject-knowledge courses" do
      it "queues AssessmentEligibilityJob job once for complete courses" do
        cs_activity1 = create(:activity, stem_course_template_no: "92f4f86e-0237-4ecc-a905-2f6c62d6b522")
        cs_activity2 = create(:activity, stem_course_template_no: "92f4f86e-0237-4ecc-a905-2f6c62d6b533")
        cs_acc_programme = create(:cs_accelerator)
        create(:programme_activity, programme_id: cs_acc_programme.id, activity_id: cs_activity1.id)
        create(:programme_activity, programme_id: cs_acc_programme.id, activity_id: cs_activity2.id)
        create(:achievement, activity_id: cs_activity1.id, user_id: user.id)
        create(:achievement, activity_id: cs_activity2.id, user_id: user.id)

        perform_job
        expect(AssessmentEligibilityJob).to have_been_enqueued.exactly(:once).with(user.id)
      end
    end

    context "when an activity cannot be found" do
      it "does not create an achievement" do
        perform_job
        expect(user.achievements.where(activity_id: "b15f8b07-2d8c-4eeb-8f22-1e4b5c86c148").exists?).to eq false
      end
    end
  end

  describe "sentry rescue handling" do
    context "with achievement completion exception" do
      before do
        allow(Sentry).to receive(:capture_exception)
        allow(Achievement).to receive(:find_or_create_by!).and_return(achievement)
        allow(achievement).to receive(:complete!).and_raise(Statesman::TransitionConflictError.new("Conflict"))
      end

      it "captures transition conflict error in sentry" do
        perform_job
        expect(Sentry).to have_received(:capture_exception).with(an_instance_of(Statesman::TransitionConflictError))
      end
    end

    context "with achievement drop exception" do
      before do
        allow(Sentry).to receive(:capture_exception)
        allow(Achievement).to receive(:find_or_create_by!).and_return(achievement_two)
        allow(achievement_two).to receive(:drop!).and_raise(Statesman::TransitionConflictError.new("Conflict"))
      end

      it "captures transition conflict error in sentry" do
        perform_job
        expect(Sentry).to have_received(:capture_exception).with(an_instance_of(Statesman::TransitionConflictError))
      end
    end

    context "with achievement validation exception" do
      before do
        create(:activity, stem_course_template_no: "92f4f86e-0237-4ecc-a905-2f6c62d6b5ae")
        allow(Rails.logger).to receive(:info)
        allow(Sentry).to receive(:capture_exception)

        invalid_achievement = Achievement.new
        invalid_achievement.errors.add(:base, "Test validation error")

        allow(Achievement).to receive(:find_or_create_by!).and_raise(ActiveRecord::RecordInvalid.new(invalid_achievement))
      end

      it "captures validation error in sentry and rails logger" do
        perform_job
        expect(Sentry).to have_received(:capture_exception).with(an_instance_of(ActiveRecord::RecordInvalid))
        expect(Rails.logger).to have_received(:info).with(/validation error/i)
      end
    end
  end
end
