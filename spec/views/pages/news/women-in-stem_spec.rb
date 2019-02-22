require 'rails_helper'

RSpec.describe('pages/news/women-in-stem', type: :view) do
  before do
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('.govuk-heading-l', text: 'Raising awareness of women in STEM')
  end

  it 'links to accelerator' do
    expect(rendered).to have_link('Find out more about the Computer Science Accelerator Programme', href: '/accelerator')
  end

  it 'has a mailto link' do
    expect(rendered).to have_link('info@computing.org', href: 'mailto:info@computing.org')
  end
end
