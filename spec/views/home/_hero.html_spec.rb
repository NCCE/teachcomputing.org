require 'rails_helper'

RSpec.describe('home/_hero', type: :view) do
  before do
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('.c-hero', text: 'Helping you teach computing')
  end

  it 'button to find out more about NCCE' do
    expect(rendered).to have_css('.c-hero--button', text: 'About the NCCE')
  end

  it 'links to the About section' do
    expect(rendered).to have_link('About the NCCE', href: '#')
  end
end
