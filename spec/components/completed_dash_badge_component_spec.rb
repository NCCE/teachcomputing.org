require "rails_helper"

RSpec.describe CompletedDashBadgeComponent, type: :component do
  let(:user) { create(:user, email: 'web@raspberrypi.org') }
  let(:completed_dash_badge_component) { described_class.new(user_id: user.id, badge_template_id: '00cd7d3b-baca-442b-bce5-f20666ed591b')}

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
    end
  end
end
