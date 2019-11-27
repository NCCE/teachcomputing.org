require 'rails_helper'

RSpec.describe('pages/bursary', type: :view) do
  before do
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('.govuk-heading-xl', text: 'Bursary entitlement')
  end

  it 'has two subtitles' do
    expect(rendered).to have_css('.govuk-heading-l', count: 2)
  end

  it 'has price table' do
    expect(rendered).to have_css('.govuk-table', count: 1)
  end

end
