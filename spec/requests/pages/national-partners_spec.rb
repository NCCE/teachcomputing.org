require 'rails_helper'

RSpec.describe PagesController do

  describe 'GET #gender-balance' do
		before do
      get national_partners_path
    end

		it 'shows the page' do
			expect(response).to render_template('pages/national-partners')
		end
  end

end
