require 'rails_helper'

RSpec.describe('pages/get-involved', type: :view) do
  before do
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('.hero__heading', text: 'Help us inspire the computing experts of the future')
  end

  it 'has a get involved section' do
    expect(rendered).to have_css('.govuk-heading-m', text: 'Get involved')
  end

  it 'has a how you can help section' do
    expect(rendered).to have_css('.govuk-heading-m', text: 'Why you should get involved')
  end

  it 'has a list of things you can do' do
    expect(rendered).to have_css('.govuk-list li', count: 4)
  end

  it 'list has headings' do
    expect(rendered).to have_css('.govuk-list h3', count: 5)
  end
end
