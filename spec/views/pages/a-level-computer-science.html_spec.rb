require 'rails_helper'

RSpec.describe('pages/a-level-computer-science', type: :view) do
  before do
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('.govuk-heading-l', text: 'A level computer science')
  end

  it 'has aside secton' do
    expect(rendered).to have_css('.ncce-aside', count: 1)
  end

  it 'has two lists' do
    expect(rendered).to have_css('.govuk-list', count: 2)
  end

  it 'has three headings' do
    expect(rendered).to have_css('.govuk-heading-m', count: 3)
  end

end
