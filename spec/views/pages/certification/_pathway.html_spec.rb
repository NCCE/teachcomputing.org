require 'rails_helper'

RSpec.describe('pages/certification/_pathway', type: :view) do
  before do
    render
  end

  it 'has the title' do
    expect(rendered).to have_css('.govuk-heading-s', text: "You'll be supported at every step along the way")
  end

  it 'has all steps' do
    expect(rendered).to have_css('.pathway__step', count: 4)
  end

  it 'has all titles' do
    expect(rendered).to have_css('.pathway__step-title', count: 4)
  end

  it 'has all paras' do
    expect(rendered).to have_css('.govuk-body', count: 4)
  end

  it 'has all sub-paras' do
    expect(rendered).to have_css('.govuk-body-s', count: 2)
  end

end
