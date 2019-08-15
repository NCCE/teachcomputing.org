require 'rails_helper'

RSpec.describe PagesController do
  describe 'GET #resources' do
    before do
      get resources_path
    end

    it 'shows the page' do
      expect(response).to render_template('pages/resources')
    end
  end
end
