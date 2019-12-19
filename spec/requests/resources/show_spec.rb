require 'rails_helper'

RSpec.describe ResourcesController do
  let(:user) { create(:user) }

  describe '#show' do
    it 'renders the index template' do
      redirect_url = URI.encode_www_form_component('https://ncce.io/Year1')
      get resources_redirect_path(redirect_url: redirect_url, year: 1)
      expect(response).to redirect_to('https://ncce.io/Year1')
    end
  end
end
