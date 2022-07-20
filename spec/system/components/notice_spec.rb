require 'rails_helper'
require 'axe/rspec'

RSpec.describe('Notice partial', type: :system) do
  context 'for /bursary' do
    before do
      stub_cms_page
      visit '/bursary'
    end

    it 'shows the notice' do
      expect(page).to have_css('.ncce-notice__container')
    end
  end

  context 'for any other page' do
    before do
      visit gender_balance_path
    end

    it 'does not show the notice' do
      expect(page).not_to have_css('.ncce-notice__container')
    end
  end
end
