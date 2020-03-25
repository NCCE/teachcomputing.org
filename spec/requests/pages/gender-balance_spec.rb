require 'rails_helper'

RSpec.describe PagesController do

  describe 'GET #gender-balance' do

		it 'shows the page' do
			expect(response).to render_template('pages/gender-balance')
		end
  end

end
