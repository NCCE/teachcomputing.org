require 'rails_helper'

RSpec.describe('pages/bursary', type: :view) do
  before do
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('.govuk-heading-l', text: 'Bursary information')
  end

  it 'has Aside section' do
    expect(rendered).to have_css('.ncce-aside', count: 1)
  end

end
