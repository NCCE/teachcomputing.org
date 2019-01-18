require 'rails_helper'

RSpec.describe('pages/certification', type: :view) do
  before do
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('.govuk-heading-l', text: 'Certification')
  end

end
