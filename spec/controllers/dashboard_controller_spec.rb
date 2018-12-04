require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
  describe 'GET #show' do
    before do
      get :show
    end

    it 'renders the correct template' do
      expect(response).to render_template('show')
    end
  end
end
