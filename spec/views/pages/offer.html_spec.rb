require 'rails_helper'

RSpec.describe('pages/offer', type: :view) do
  before do
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('.govuk-heading-l', text: 'What we offer')
  end

  it 'has 5 sections' do
    expect(rendered).to have_css('.govuk-heading-s', count: 5)
  end

end
