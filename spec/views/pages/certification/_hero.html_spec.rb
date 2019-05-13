require 'rails_helper'

RSpec.describe('pages/certification/_hero', type: :view) do
  before do
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('h1.govuk-heading-m', text: 'GCSE computer science subject knowledge')
  end

  it 'has two subheadings' do
    expect(rendered).to have_css('p.govuk-body-m', text: 'The National Centre for Computing Education certificate in')
  end

  it 'has two notepad images' do
    expect(rendered).to have_css('.certification-hero__image', count: 2)
  end

  it 'has one notepad image for mobile' do
    expect(rendered).to have_css('.certification-hero__image--mobile', count: 1)
  end

  it 'has one notepad image for non-mobile' do
    expect(rendered).to have_css('.certification-hero__image--tablet', count: 1)
  end

end
