require "rails_helper"

RSpec.describe BadgeAssignmentCheckJob, type: :job do
  let!(:primary_certificate) { create(:primary_certificate, :with_activity_groupings) }
  let!(:badge) { create(:badge, :active, programme: primary_certificate, credly_badge_template_id: "00cd7d3b-baca-442b-bce5-f20666ed591b") }
  let(:f2f_activity) { create(:activity, programmes: [primary_certificate]) }
  let(:user_with_badge) { create(:user) }
  let(:user_without_badge) { create(:user) }
  let(:user_no_activity) { create(:user) }
  let(:user_with_badge_programme_enrolment) { create(:user_programme_enrolment, programme_id: primary_certificate.id, user_id: user_with_badge.id) }
  let(:user_without_badge_programme_enrolment) { create(:user_programme_enrolment, programme_id: primary_certificate.id, user_id: user_without_badge.id) }
  let(:user_no_activity_programme_enrolment) { create(:user_programme_enrolment, programme_id: primary_certificate.id, user_id: user_no_activity.id) }

  let(:setup_users) {
    user_with_badge_programme_enrolment
    user_without_badge_programme_enrolment
    user_no_activity_programme_enrolment
    create(:completed_achievement, user: user_with_badge, activity: f2f_activity)
    create(:completed_achievement, user: user_without_badge, activity: f2f_activity)
  }

  describe "#perform" do
    include ActiveJob::TestHelper

    before do
      setup_users
      stub_issued_badges(user_with_badge.id)
      stub_issued_badges_empty(user_without_badge.id)
    end

    it "should not match user with existing badge" do
      expect(primary_certificate.user_qualifies_for_credly_badge?(user_with_badge)).to be true
      matches = described_class.perform_now(days_to_check: 10, programmes_to_check: [primary_certificate])
      expect(matches.include?([user_with_badge, primary_certificate])).to be false
    end

    it "should include user without a badge" do
      matches = described_class.perform_now(days_to_check: 10, programmes_to_check: [primary_certificate])
      expect(matches.include?([user_without_badge, primary_certificate])).to be true
    end

    it "should not include user without f2f activity" do
      matches = described_class.perform_now(days_to_check: 10, programmes_to_check: [primary_certificate])
      expect(matches.include?([user_no_activity, primary_certificate])).to be false
    end
  end
end
