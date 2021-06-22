require "rails_helper"

RSpec.describe CompletedDashBadgeComponent, type: :component do
  let(:user) { create(:user, email: 'web@raspberrypi.org') }
  let(:badge) { create(:badge, :active) }
  let(:awarded_badge) { Credly::Badge.by_badge_template_ids(user.id, badge.programme.id) }
  let(:completed_dash_badge_component) { described_class.new(badge: awarded_badge, tracking_event_category: 'category', tracking_event_label: 'label') }

  context 'when the badges feature is disabled' do
    before do
      stub_issued_badges(user.id)
      render_inline(completed_dash_badge_component)
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

    context 'when the achievement is complete' do
      before do
        render_inline(completed_dash_badge_component)
      end

      it "the badges image" do
        expect(rendered_component).to have_css('.completed-dash-badge-component__badge')
      end

      it "a link to the badge" do
        expect(rendered_component).to have_css('.ncce-link')
      end

      it "the congratulatory copy" do
        expect(rendered_component).to have_css('.completed-dash-badge-component__content')
      end

      it 'adds data attributes when passed' do
        expect(rendered_component).to have_selector("a[data-event-category='category']")
        expect(rendered_component).to have_selector("a[data-event-label='label']")
        expect(rendered_component).to have_selector("a[data-event-action='click']")
      end
    end
  end
end
