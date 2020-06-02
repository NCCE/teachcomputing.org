require 'rails_helper'

RSpec.describe('pages/certification/_pathway', type: :view) do
  before do
    render
  end

  it 'has the title' do
    expect(rendered).to have_css('.govuk-heading-s', text: "Learning pathways for teachers")
  end

  it 'has all items' do
    expect(rendered).to have_css('.pathway__item', count: 5)
  end

  it 'has all PDFs' do
    expect(rendered).to have_css('.pathway__item', count: 5)
  end

  it 'has coursed button' do
    expect(rendered).to have_css('.button', text: 'Browse our courses')
  end

end
