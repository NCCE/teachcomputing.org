require 'rails_helper'

RSpec.describe('pages/press/index', type: :view) do
  before do
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('.govuk-heading-l', text: 'Press Releases')
  end

  it 'contains the correct number of posts' do
    expect(rendered).to have_css('.ncce-link--heading', count: 1)
  end
end
