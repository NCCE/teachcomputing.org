require 'rails_helper'

RSpec.describe('pages/about', type: :view) do
  before do
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('.hero__heading', text: 'About')
  end

  it 'links to consortium' do
    expect(rendered).to have_css('.ncce-link', count: 3)
  end

  it 'has a get involved link' do
    expect(rendered).to have_link('Get involved', href: '/get-involved')
  end
end
