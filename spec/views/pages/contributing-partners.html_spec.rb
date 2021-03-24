require 'rails_helper'

RSpec.describe('pages/contributing-partners', type: :view) do
  before do
    render
  end

  it 'has a main paragraph' do
    expect(rendered).to have_css('.govuk-body-l', count: 1)
  end

  it 'has 10 cards' do
    expect(rendered).to have_css('.dark_card', count: 10)
  end
end
