require 'rails_helper'

RSpec.describe('pages/news/index', type: :view) do
  before do
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('.govuk-heading-l', text: 'News & Updates')
  end

  it 'contains the correct number of posts' do
    expect(rendered).to have_css('.ncce-news-archive__item', count: 3)
  end
end
