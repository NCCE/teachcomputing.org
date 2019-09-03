require 'rails_helper'

RSpec.describe('pages/maintenance', type: :view) do
  before do
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('.govuk-heading-m', text: 'We are currently performing planned maintenance on the site.')
  end
end
