require 'rails_helper'

RSpec.describe('pages/certification/_hero', type: :view) do
  before do
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('.govuk-heading-m', text: 'GCSE computer science subject knowledge')
  end

  it 'has two subheadings' do
    expect(rendered).to have_css('.govuk-heading-s', count: 2)
  end

  it 'has icon' do
    expect(rendered).to have_css('.certification-hero__image', count: 1)
  end

end
