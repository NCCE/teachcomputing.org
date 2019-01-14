require 'rails_helper'

RSpec.describe('home/_hero', type: :view) do
  before do
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('.ncce-hero', text: 'Helping you teach computing')
  end

  it 'button to find out more about NCCE' do
    expect(rendered).to have_css('.ncce-hero__button--link', text: 'Read more about the centre')
  end

  it 'links to the About section' do
    expect(rendered).to have_link('Read more about the centre', href: '/about')
  end
end
