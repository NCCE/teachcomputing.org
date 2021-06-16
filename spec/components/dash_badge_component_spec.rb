require "rails_helper"

RSpec.describe DashBadgeComponent, type: :component do
  let(:user) { create(:user, email: 'web@raspberrypi.org') }
  let(:badge) { Credly::Badge.by_badge_template_id(user.id, '00cd7d3b-baca-442b-bce5-f20666ed591b') }
  let(:dash_badge_component) { described_class.new(badge: badge, tracking_event_category: 'category', tracking_event_label: 'label') }
  let(:fixed_width_dash_badge_component) { described_class.new(badge: badge, fixed_width: true, tracking_event_category: 'category', tracking_event_label: 'label') }

  context 'when the badges feature is disabled' do
    context 'when full width is true' do
      before do
        stub_issued_badges(user.id)
        render_inline(fixed_width_dash_badge_component)
      end

      it 'has the full width class applied' do
        expect(rendered_component).to have_css('.dash-badge-component-fixed-width')
      end
    end

    before do
      stub_issued_badges(user.id)
      render_inline(dash_badge_component)
    end

    it 'does not render' do
      expect(rendered_component).to eq ''
    end
  end

  context 'when the badging feature is enabled' do
    before do
      stub_issued_badges(user.id)
      stub_feature_flags({ badges_enabled: true })
    end

    context 'when the badging feature flag is enabled' do
      before do
        render_inline(dash_badge_component)
      end

      it "the badges image" do
        expect(rendered_component).to have_css('.dash-badge-component__badge')
      end

      it "a link to the badge" do
        expect(rendered_component).to have_css('.ncce-link')
      end

      it "the congratulatory copy" do
        expect(rendered_component).to have_css('.dash-badge-component__content')
      end

      it 'adds data attributes when passed' do
        expect(rendered_component).to have_selector("a[data-event-category='category']")
        expect(rendered_component).to have_selector("a[data-event-label='label']")
        expect(rendered_component).to have_selector("a[data-event-action='click']")
      end

      it 'does not have the full width class applied' do
        expect(rendered_component).not_to have_css('.dash-badge-component-fixed-width')
      end
    end
  end
end
