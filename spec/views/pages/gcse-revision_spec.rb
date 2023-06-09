require 'rails_helper'

RSpec.describe('pages/gcse-revision', type: :view) do
  before do
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('.govuk-heading-l', text: 'Isaac Computer Science for GCSE')
  end

  it 'has aside section' do
    expect(rendered).to have_css('.aside-component', count: 1)
  end

  it 'has four lists' do
    expect(rendered).to have_css('.govuk-list', count: 4)
  end

  it 'has three headings' do
    expect(rendered).to have_css('.govuk-heading-s', count: 4)
  end
end
