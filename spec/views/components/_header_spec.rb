require 'rails_helper'

RSpec.describe('components/_header', type: :view) do
  let(:user) { create(:user) }

  context 'when a user is signed in' do
    before do
      allow(view).to receive(:current_user).and_return(user)
      render
    end

    it 'shows a link to your dashboard' do
      expect(rendered).to have_css('.govuk-header__navigation-item', text: 'Your dashboard')
    end

    it 'shows a link to logout' do
      expect(rendered).to have_css('.govuk-header__navigation-item', text: 'Logout')
    end
  end

  context 'when there is not signed in user' do
    before do
      allow(view).to receive(:current_user).and_return(nil)
      render
    end

    it 'shows link to sign up' do
      expect(rendered).to have_css('.govuk-header__navigation-item', text: 'Create an account / Login')
    end

    it 'does not show a link to your dashboard' do
      expect(rendered).not_to have_css('.govuk-header__navigation-item', text: 'Your dashboard')
    end
  end
end
