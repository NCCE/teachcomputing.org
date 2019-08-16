require 'rails_helper'

RSpec.describe('pages/maintenance', type: :view) do
  before do
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('.govuk-heading-m', text: 'Something went wrong with the website')
  end

  it 'has homepage link' do
    expect(rendered).to have_link('Back to the website', href: '/')
  end

end
