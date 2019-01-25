require 'rails_helper'

RSpec.describe('pages/terms-conditions', type: :view) do
  before do
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('.govuk-heading-l', text: 'Terms and Conditions National Centre for Computing Education')
  end

  it 'has 11 sections' do
    expect(rendered).to have_css('.govuk-heading-m', count: 11)
  end

  it 'has a contact link' do
    expect(rendered).to have_link('finance@stem.org.uk', href: 'mailto:finance@stem.org.uk')
  end
end
