require 'rails_helper'

RSpec.describe('pages/press/posts/simon-peyton-jones-chair-ncce', type: :view) do
  before do
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('.govuk-heading-l', text: 'Top computer scientist chosen to lead National Centre for Computing Education')
  end

  it 'notes to editors' do
    expect(rendered).to have_css('.govuk-heading-s', text: 'Notes to editors:')
  end
end
