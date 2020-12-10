require 'rails_helper'

RSpec.describe DashboardController do
  let(:user) { create(:user) }
  let(:complete_achievements) { create_list(:completed_achievement, 3, user: user) }
  let(:enrolled_achievement) { create(:achievement, user: user) }
  let(:activity) { create(:activity, :cs_accelerator_diagnostic_tool) }
  let(:diagnostic_achievement) { create(:achievement, user: user, activity: activity) }

  describe '#show' do
    describe 'while logged in' do
      before do
				create(:primary_certificate)
				create(:secondary_certificate)
        create(:cs_accelerator)
        [diagnostic_achievement, complete_achievements, enrolled_achievement]
        allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
        get dashboard_path
      end

      it 'assigns the users complete achievements' do
        expect(assigns(:achievements).count).to eq 3
      end

      it 'does not include diagnostic achievement in assigned achievements' do
        expect(assigns(:achievements)).not_to include diagnostic_achievement
      end

      it 'renders the correct template' do
        expect(response).to render_template('show')
      end
    end

    describe 'while logged out' do
      before do
        get dashboard_path
      end

      it 'redirects to login' do
        expect(response).to redirect_to(/register/)
      end
    end
  end
end
