require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
  let(:user) { create(:user) }

  describe 'GET #show' do
    describe 'while logged in' do
      before do
        allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
        get :show
      end

      it 'renders the correct template' do
        expect(response).to render_template('show')
      end
    end

    describe 'while logged out' do
      before do
        get :show
      end

      it 'should redirect to login' do
        expect(response).to redirect_to(login_path)
      end
    end
  end
end
