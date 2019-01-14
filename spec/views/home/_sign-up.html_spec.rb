require 'rails_helper'

RSpec.describe('home/_sign-up', type: :view) do
  before do
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('.ncce-sign-up', text: 'Sign up')
  end

  it 'links to the Sign up section' do
    expect(rendered).to have_link('Sign up', href: '#')
  end

  it('renders the correct number of bullets') do
    expect(rendered).to(have_css('.ncce-sign-up__list--item', count: 3))
  end

end
