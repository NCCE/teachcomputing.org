require 'rails_helper'

RSpec.describe('pages/maintenance', type: :view) do
  before do
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('.govuk-heading-m', text: 'Scheduled maintenance')
  end
end
