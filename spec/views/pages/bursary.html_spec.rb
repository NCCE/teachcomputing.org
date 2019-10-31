require 'rails_helper'

RSpec.describe('pages/bursary', type: :view) do
  before do
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('.govuk-heading-xl', text: 'Bursary entitlement')
  end
end
