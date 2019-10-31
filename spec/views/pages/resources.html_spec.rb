require 'rails_helper'

RSpec.describe('pages/resources', type: :view) do
  let(:user) { create(:user) }

  it 'has a title' do
    render
    expect(rendered).to have_css('.govuk-heading-xl', text: 'Teaching resources')
  end

  it 'has key stage headings' do
    render
    expect(rendered).to have_css('.resources-key-stage', count: 3)
  end

  it 'has year headings' do
    render
    expect(rendered).to have_css('.resources-year__heading', count: 6)
  end

  it 'has resource lists for each year' do
    render
    expect(rendered).to have_css('.resources-year__lesson-list', count: 6)
  end

  it 'has asides for each year' do
    render
    expect(rendered).to have_css('.resources-aside', count: 6)
  end

  context 'when a user is not signed in' do
    before do
      render
    end

    it 'user sees login button' do
      expect(rendered).to have_css('.primary-button--aside', text: 'Log in to access')
    end
  end

  context 'when a user is signed in' do
    before do
      allow(view).to receive(:current_user).and_return(user)
      render
    end

    it 'user can access downloads' do
      expect(rendered).to have_css('.primary-button--aside', text: 'Access year 7 resources')
    end
  end
end
