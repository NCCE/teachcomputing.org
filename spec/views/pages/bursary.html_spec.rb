require 'rails_helper'

RSpec.describe('pages/bursary', type: :view) do
  before do
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('.govuk-heading-l', text: 'Bursary entitlement')
  end

  it 'has 8 subtitles' do
    expect(rendered).to have_css('.govuk-heading-s', count: 8)
  end

  it 'has a price table' do
    expect(rendered).to have_css('.govuk-table', count: 1)
  end

  it 'has a bullet list' do
    expect(rendered).to have_css('.govuk-list--bullet', count: 1)
  end

end
