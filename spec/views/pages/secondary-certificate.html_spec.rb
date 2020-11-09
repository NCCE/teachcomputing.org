require 'rails_helper'

RSpec.describe('pages/secondary-certificate', type: :view) do
  let(:user) { create(:user) }
  let(:programme) { create(:programme, slug: 'secondary-certificate') }

  context 'when a user is not signed in' do
    before do
      @programme = programme
      assign(:current_user, nil)
      render
    end

    it 'has a heading' do
      expect(rendered).to have_css('.govuk-heading-m', text: 'Welcome to the Secondary Computing Programme')
    end

    it 'has diagram' do
      expect(rendered).to have_css('.pathway-wrapper', count: 1)
    end

    it 'has aside section' do
      expect(rendered).to have_css('.ncce-aside', count: 1)
    end

    it 'has expected title' do
      expect(rendered).to have_css('.ncce-aside__title', text: 'How to enrol')
    end

    it 'has Account button' do
      expect(rendered).to have_css('.button--aside', text: 'Create an account')
    end

    it 'has a Log in link' do
      expect(rendered).to have_link('log in', href: '/auth/stem')
    end
  end

  context 'when a user is signed in' do
    before do
      @programme = programme
      assign(:current_user, user)
      render
    end

    it 'has Enrol button' do
      expect(rendered).to have_css('.button--aside', text: 'Enrol on this certificate')
    end

    it 'has no Log in link' do
      expect(rendered).not_to have_link('log in', href: '/auth/stem')
    end
  end
end
