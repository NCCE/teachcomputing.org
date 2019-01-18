require 'rails_helper'

RSpec.describe PagesController do
  let(:user) { create(:user) }

  describe '#login' do
    context 'with a current user' do
      before do
        allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
        get login_path
      end

      it 'should redirect to the dashboard' do
        expect(response).to redirect_to(dashboard_path)
      end
    end

    context 'without a current user' do
      before do
        # allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(nil)
        get login_path
      end

      it 'should redirect to login' do
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
