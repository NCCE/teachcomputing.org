require "rails_helper"

RSpec.describe Achiever::FetchUsersCompletedCoursesFromAchieverJob, type: :job do
  subject(:perform_job) { described_class.perform_now(user) }

  let(:user) { create(:user) }
  let(:activity_one) { create(:activity, stem_course_template_no: "92f4f86e-0237-4ecc-a905-2f6c62d6b5ae") }

  before do
    stub_attendance_sets
    stub_delegate
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
        expect(CertificatePendingTransitionJob).to have_been_enqueued.exactly(:once)
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
          expect { perform_job }.to change { achievement.current_state }.to("complete")
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
        expect(AssessmentEligibilityJob).to have_been_enqueued.exactly(:once)
      end
    end

    context "when an activity cannot be found" do
      it "does not create an achievement" do
        perform_job
        expect(user.achievements.where(activity_id: "b15f8b07-2d8c-4eeb-8f22-1e4b5c86c148").exists?).to eq false
      end
    end
  end
end
