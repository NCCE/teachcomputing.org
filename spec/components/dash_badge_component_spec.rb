require "rails_helper"

RSpec.describe DashBadgeComponent, type: :component do
  let(:user) { create(:user, email: "web@teachcomputing.org") }
  let(:badge) { create(:badge, :active, credly_badge_template_id: "00cd7d3b-baca-442b-bce5-f20666ed591b") }
  let(:awarded_badge) { Credly::Badge.by_programme_badge_template_ids(user.id, badge.programme.badges.pluck(:credly_badge_template_id)) }
  let(:dash_badge_component) { described_class.new(badge: awarded_badge, tracking_event_category: "category", tracking_event_label: "label") }
  let(:fixed_width_dash_badge_component) { described_class.new(badge: awarded_badge, fixed_width: true, tracking_event_category: "category", tracking_event_label: "label") }

  before do
    stub_issued_badges(user.id)
  end

  context "when fixed width is true" do
    before do
      stub_issued_badges(user.id)
      render_inline(fixed_width_dash_badge_component)
    end

    it "has the full width class applied" do
      expect(page).to have_css(".dash-badge-component-fixed-width")
    end
  end

  context "when the badging feature flag is enabled" do
    before do
      render_inline(dash_badge_component)
    end

    it "the badges image" do
      expect(page).to have_css(".dash-badge-component__badge")
    end

    it "a link to the badge" do
      expect(page).to have_css(".ncce-link")
    end

    it "the congratulatory copy" do
      expect(page).to have_css(".dash-badge-component__content")
    end

    it "adds data attributes when passed" do
      expect(page).to have_selector("a[data-event-category='category']")
      expect(page).to have_selector("a[data-event-label='label']")
      expect(page).to have_selector("a[data-event-action='click']")
    end

    it "does not have the full width class applied" do
      expect(page).not_to have_css(".dash-badge-component-fixed-width")
    end
  end
end
