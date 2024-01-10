require "rails_helper"

RSpec.describe CompletedDashBadgeComponent, type: :component do
  let(:user) { create(:user, email: "web@teachcomputing.org") }
  let(:badge) { create(:badge, :active, credly_badge_template_id: "00cd7d3b-baca-442b-bce5-f20666ed591b") }
  let(:awarded_badge) { Credly::Badge.by_programme_badge_template_ids(user.id, badge.programme.badges.pluck(:credly_badge_template_id)) }
  let(:completed_dash_badge_component) { described_class.new(badge: awarded_badge, tracking_event_category: "category", tracking_event_label: "label") }

  context "when badge is not present" do
    before do
      stub_issued_badges_empty(user.id)
      render_inline(completed_dash_badge_component)
    end

    it "does not render" do
      expect(page).not_to have_css(".completed-dash-badge-component")
    end
  end

  context "when the achievement is complete" do
    before do
      stub_issued_badges(user.id)
      render_inline(completed_dash_badge_component)
    end

    it "the badges image" do
      expect(page).to have_css(".completed-dash-badge-component__badge")
    end

    it "a link to the badge" do
      expect(page).to have_css(".ncce-link")
    end

    it "the congratulatory copy" do
      expect(page).to have_css(".completed-dash-badge-component__content")
    end

    it "adds data attributes when passed" do
      expect(page).to have_selector("a[data-event-category='category']")
      expect(page).to have_selector("a[data-event-label='label']")
      expect(page).to have_selector("a[data-event-action='click']")
    end
  end
end
