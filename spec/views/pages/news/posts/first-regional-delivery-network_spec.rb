require 'rails_helper'

RSpec.describe('pages/news/posts/first-regional-delivery-network', type: :view) do
  before do
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('.govuk-heading-l', text: 'Boost in computing support for local schools')
  end

  it 'has a link to the courses page' do
    expect(rendered).to have_link('https://teachcomputing.org/courses', href: 'https://teachcomputing.org/courses')
  end
end
