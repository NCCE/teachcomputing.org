require "rails_helper"

RSpec.describe SecondaryDashBadgeComponent, type: :component do
  let(:user) { create(:user, email: 'web@raspberrypi.org') }
  let(:achievement) { create(:achievement, user: user) }
  let(:dash_badge_component) { described_class.new(achievement: achievement, badge_template_id: '00cd7d3b-baca-442b-bce5-f20666ed591b', fixed_width: false, user_id: user.id, tracking_event_category: 'category', tracking_event_label: 'label')}
  let(:fixed_width_dash_badge_component) { described_class.new(achievement: achievement, badge_template_id: '00cd7d3b-baca-442b-bce5-f20666ed591b', fixed_width: true, user_id: user.id, tracking_event_category: 'category', tracking_event_label: 'label')}

  context 'when the badges feature is disabled' do
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

    context 'but the achievement is not in a state of complete' do
      it 'does not render' do
        render_inline(dash_badge_component)
        expect(rendered_component).to eq ''
      end
    end

    context 'when the achievement is complete' do
      before do
        achievement.transition_to(:complete)
        render_inline(dash_badge_component)
      end

      it "the badges image" do
        expect(rendered_component).to have_css('.secondary-dash-badge-component__badge')
      end

      it "a link to the badge" do
        expect(rendered_component).to have_css('.ncce-link')
      end

      it "the congratulatory copy" do
        expect(rendered_component).to have_css('.secondary-dash-badge-component__content')
      end

      it 'adds data attributes when passed' do
        expect(rendered_component).to have_selector("a[data-event-category='category']")
        expect(rendered_component).to have_selector("a[data-event-label='label']")
        expect(rendered_component).to have_selector("a[data-event-action='click']")
      end
    end

    context 'when fixed width is true' do
      before do
        achievement.transition_to(:complete)
        render_inline(fixed_width_dash_badge_component)
      end
      it 'does render dash-badge-component-fixed class' do
        expect(rendered_component).to have_css('.dash-badge-component-fixed')
      end
    end

    context 'when fixed width is false' do
      before do
        achievement.transition_to(:complete)
        render_inline(dash_badge_component)
      end

      it 'does not render dash-badge-component-fixed class' do
        expect(rendered_component).not_to have_css('.dash-badge-component-fixed')
      end
    end
  end
end
