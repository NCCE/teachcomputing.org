require 'rails_helper'

RSpec.describe('pages/bursary', type: :view) do
  before do
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('.govuk-heading-xl', text: 'Bursaries and fees')
  end

  it 'has five subtitles' do
    expect(rendered).to have_css('.govuk-heading-m', count: 5)
  end

  it 'has price table' do
    expect(rendered).to have_css('.govuk-table', count: 3)
  end

end
