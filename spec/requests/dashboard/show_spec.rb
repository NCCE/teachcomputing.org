require 'rails_helper'

RSpec.describe DashboardController do
  let(:user) { create(:user) }
  let(:complete_achievements) { create_list(:completed_achievement, 3, user: user) }
  let(:commenced_achievement) { create(:achievement, user: user) }
  let(:activity) { create(:activity, :diagnostic_tool) }
  let(:programme) { create(:programme, slug: 'cs-accelerator') }

  describe '#show' do
    describe 'while logged in' do
      before do
        programme
        [activity, complete_achievements, commenced_achievement]
        allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
        get dashboard_path
      end

      it 'assigns the users complete achievements' do
        expect(assigns(:achievements)).to eq complete_achievements
      end

      it 'does not assign achievements in the state of commenced' do
        expect(assigns(:achievements)).not_to include commenced_achievement
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
        expect(response).to redirect_to(login_path)
      end
    end
  end
end
