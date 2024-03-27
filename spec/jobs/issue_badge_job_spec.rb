require "rails_helper"

RSpec.describe IssueBadgeJob, type: :job do
  let!(:user) { create(:user, email: "web@teachcomputing.org") }
  let!(:programme) { create(:cs_accelerator) }
  let(:badge) { create(:badge, :active, programme_id: programme.id, credly_badge_template_id: "00cd7d3b-baca-442b-bce5-f20666ed591b") }
  let(:user_programme_enrolment) { create(:user_programme_enrolment, user:, programme:) }
  let!(:achievement) { create(:completed_achievement, user:) }
  let!(:programme_activity) { create(:programme_activity, activity: achievement.activity, programme:) }

  describe "#perform" do
    before do
      allow(Credly::Badge).to receive(:issue).and_return(true)
      stub_issued_badges_empty(user.id)
      badge
    end

    it "should skip as user is not enrolled" do
      described_class.perform_now(achievement:)
      expect(Credly::Badge).not_to have_received(:issue)
    end

    context "when the user is enrolled" do
      before do
        user_programme_enrolment
      end

      it "calls Credly::Badge.issue" do
        described_class.perform_now(achievement:)
        expect(Credly::Badge).to have_received(:issue)
      end
    end

    context "when a assessment_attempt is passed" do
      it "should skip as user is not enrolled" do
        a_level = create(:a_level)
        assessment = create(:assessment, programme: a_level)
        assessment_attempt = create(:completed_assessment_attempt, assessment:, user:)
        create(:badge, :active, programme: a_level, credly_badge_template_id: "00cd7d3b-baca-442b-bce5-f20666ed591c")

        described_class.perform_now(assessment_attempt:)
        expect(Credly::Badge).not_to have_received(:issue)
      end

      context "when the user is enrolled and has completed certificate" do
        it "calls Credly::Badge.issue" do
          a_level = create(:a_level)
          assessment = create(:assessment, programme: a_level)
          assessment_attempt = create(:completed_assessment_attempt, assessment:, user:)
          create(:badge, :active, programme: a_level, credly_badge_template_id: "00cd7d3b-baca-442b-bce5-f20666ed591d")
          create(:user_programme_enrolment, programme: a_level, user:)

          described_class.perform_now(assessment_attempt:)
          expect(Credly::Badge).to have_received(:issue)
        end
      end
    end
  end
end
