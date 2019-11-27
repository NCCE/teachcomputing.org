require 'rails_helper'

RSpec.describe('pages/terms-conditions', type: :view) do
  let(:user) { create(:user) }

  it 'has a title' do
    render
    expect(rendered).to have_css('.govuk-heading-xl', text: 'Terms and Conditions National Centre for Computing Education')
  end

  it 'has 11 sections' do
    render
    expect(rendered).to have_css('.govuk-heading-m', count: 11)
  end

  it 'has a contact link' do
    render
    expect(rendered).to have_link('finance@stem.org.uk', href: 'mailto:finance@stem.org.uk')
  end

  context 'when a user is signed in' do
    before do
      allow(view).to receive(:current_user).and_return(user)
      render
    end

    it 'has a dashboard link' do
      expect(rendered).to have_link('National Centre for Computing Education website', href: '/dashboard')
    end

  end

  context 'when there is not signed in user' do
    before do
      allow(view).to receive(:current_user).and_return(nil)
      render
    end

    it 'has a login link' do
      expect(rendered).to have_link('National Centre for Computing Education website', href: /register/)
    end
  end
end
