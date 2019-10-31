require 'rails_helper'

RSpec.describe('pages/primary-certificate', type: :view) do
  let(:user) { create(:user) }
  let(:programme) { create(:programme, slug: 'primary-certificate') }

  before do
    @programme = programme
    render
  end

  it 'has a heading' do
    expect(rendered).to have_css('.govuk-heading-m', text: 'Welcome to the Primary Computing Programme')
  end

  it 'has diagram' do
    expect(rendered).to have_css('.pathway-wrapper', count: 1)
  end

  it 'has aside section' do
    expect(rendered).to have_css('.ncce-aside', count: 1)
  end

  context 'when a user is signed in' do
    before do
      allow(view).to receive(:current_user).and_return(user)
      render
    end

    it 'has Enrol title' do
      expect(rendered).to have_css('.ncce-aside__title', text: 'Enrol')
    end

    it 'has Enrol button' do
      expect(rendered).to have_css('.primary-button--aside', text: 'Enrol on this certificate')
    end

    it 'shows the create account step as complete' do
      expect(rendered).to have_css('.ncce-aside__check-mark', count: 1)
    end
  end

  context 'when there is not signed in user' do
    before do
      allow(view).to receive(:current_user).and_return(nil)
      render
    end

    it 'has How to enrol title' do
      expect(rendered).to have_css('.ncce-aside__title', text: 'How to enrol')
    end

    it 'has Account button' do
      expect(rendered).to have_css('.primary-button--aside', text: 'Create an account')
    end

    it 'has a Log in link' do
      expect(rendered).to have_css('.ncce-link', text: 'log in')
    end

    it 'doesn\'t show the create account step as complete' do
      expect(rendered).to have_css('.ncce-aside__check-mark', count: 0)
    end
  end
end
