require 'rails_helper'

RSpec.describe('home/_sign-up', type: :view) do
  before do
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('.c-sign-up', text: 'Sign up to the NCCE')
  end

  it 'links to the Sign up section' do
    expect(rendered).to have_link('Sign up to the NCCE', href: '#'))
  end

  it('renders the correct number of bullets') do
    expect(rendered).to(have_css('.c-sign-up__list--item', count: 3))
  end

end
