require 'rails_helper'

RSpec.describe('pages/cs-accelerator', type: :view) do
  let(:user) { create(:user) }
  let(:programme) { create(:programme, slug: 'cs-accelerator') }

  before do
    @programme = programme
    render
  end

  it 'has a heading' do
    expect(rendered).to have_css('h1.govuk-heading-m', text: 'Welcome to Computer Science Accelerator')
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
      expect(rendered).to have_css('.button--aside', text: 'Enrol on this certificate')
    end
  end

  context 'when there is not signed in user' do
    before do
      allow(view).to receive(:current_user).and_return(nil)
      render
    end

    it 'has How to enrol title' do
      expect(rendered).to have_css('.ncce-aside__title', text: 'Enrol on the programme')
    end

    it 'has Account button' do
      expect(rendered).to have_css('.button--aside', text: 'Enrol now')
    end
  end
end
