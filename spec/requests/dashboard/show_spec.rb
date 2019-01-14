require 'rails_helper'

RSpec.describe DashboardController do
  let(:user) { create(:user) }
  let(:achievements) { create(:achievements, user: user) }

  describe '#show' do
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
end