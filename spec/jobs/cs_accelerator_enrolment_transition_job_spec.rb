require "rails_helper"

RSpec.describe CSAcceleratorEnrolmentTransitionJob, type: :job do
  let(:cs_accelerator) { create(:cs_accelerator) }
  let(:user) { create(:user) }
  let(:user_programme_enrolment) { create(:user_programme_enrolment, programme_id: cs_accelerator.id, user_id: user.id) }
  let(:secondary_certificate) { create(:secondary_certificate) }
  let(:assessment) { create(:assessment, programme: cs_accelerator) }
  let(:successful_assessment_attempt) { create(:completed_assessment_attempt, user:, assessment:) }
  let(:secondary_user_programme_enrolment) { create(:user_programme_enrolment, programme_id: secondary_certificate.id, user_id: user.id) }
  let(:programme_activity_groupings) { create_list(:programme_activity_grouping, 3, :with_activities, programme: secondary_certificate) }

  describe "#perform" do
    before do
      successful_assessment_attempt
      user_programme_enrolment
      described_class.perform_now(user, {certificate_number: "10"})
      secondary_user_programme_enrolment
      programme_activity_groupings
    end

    it "transitions to failed" do
      expect(user_programme_enrolment.current_state).to eq "complete"
    end

    it "contains the certificate number meta" do
      expect(user_programme_enrolment.last_transition.metadata["certificate_number"]).to eq "10"
    end

    context "when the user has not completed secondary PAGs" do
      it "secondary shouldn't be pending" do
        described_class.perform_now(user, certificate_number: "10")

        expect(secondary_user_programme_enrolment.in_state?(:pending)).to eq false
      end
    end

    context "when the user has completed all secondary PAGs" do
      it "secondary should be pending" do
        programme_activity_groupings.each do |group|
          create(:achievement, user_id: user.id, activity_id: group.programme_activities.first.activity.id).transition_to(:complete)
        end

        described_class.perform_now(user, certificate_number: "10")

        expect(secondary_user_programme_enrolment.in_state?(:pending)).to eq true
      end
    end
  end
end
