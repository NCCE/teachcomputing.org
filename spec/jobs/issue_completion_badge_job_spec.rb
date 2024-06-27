require "rails_helper"

RSpec.describe IssueCompletionBadgeJob, type: :job do
  let!(:user) { create(:user, email: "web@teachcomputing.org") }
  let!(:programme) { create(:cs_accelerator) }
  let!(:badge) { create(:badge, :active, :completion, programme:, credly_badge_template_id: "00cd7d3b-baca-442b-bce5-f20666ed591b") }
  let(:user_programme_enrolment) { create(:user_programme_enrolment, programme:, user:) }
  let(:programme_no_badge) { create(:primary_certificate) }
  let(:user_programme_enrolment_primary) { create(:user_programme_enrolment, programme: programme_no_badge, user:) }

  before do
    allow(Credly::Badge).to receive(:issue).and_return(true)
  end

  context "when programme complete" do
    before do
      allow_any_instance_of(Programmes::CSAccelerator).to receive(:user_meets_completion_requirement?).and_return(true)
      allow_any_instance_of(Programmes::PrimaryCertificate).to receive(:user_meets_completion_requirement?).and_return(true)
      user_programme_enrolment.transition_to(:complete)
    end

    context "user has no badge already" do
      before do
        stub_issued_badges_empty(user.id)
      end

      it "should issue badge" do
        described_class.perform_now(user_programme_enrolment)
        expect(Credly::Badge).to have_received(:issue).with(user.id, badge.credly_badge_template_id)
      end

      it "should not issue badge if no badges exist" do
        described_class.perform_now(user_programme_enrolment_primary)
        expect(Credly::Badge).not_to have_received(:issue)
      end
    end

    context "user already has a badge" do
      before do
        stub_issued_badges(user.id)
      end

      it "should not issue badge" do
        described_class.perform_now(user_programme_enrolment)
        expect(Credly::Badge).not_to have_received(:issue).with(user.id, badge.credly_badge_template_id)
      end
    end
  end
end
