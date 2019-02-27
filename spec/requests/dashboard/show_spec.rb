require 'rails_helper'

RSpec.describe DashboardController do
  let(:user) { create(:user) }
  let(:achievements) { create(:achievements, user: user) }

  describe '#show' do
    describe 'while logged in' do
      before do
        allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
        get dashboard_path
      end

      it 'assigns the users achievements' do
        expect(assigns(:achievements)).to eq user.achievements
      end

      it 'renders the correct template' do
        expect(response).to render_template('show')
      end
    end

    describe 'while logged out' do
      before do
        get dashboard_path
      end

      it 'should redirect to login' do
        expect(response).to redirect_to(login_path)
      end
    end
  end
end
