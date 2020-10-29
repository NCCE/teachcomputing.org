require 'rails_helper'

RSpec.describe PagesController do
  describe 'GET #secondary-senior-leaders' do
    before do
      get secondary_senior_leaders_path
    end

    it 'shows the page' do
      expect(response).to render_template('pages/secondary-senior-leaders')
    end
  end
end
