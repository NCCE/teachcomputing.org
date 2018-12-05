require 'rails_helper'

RSpec.describe('home/_mailing', type: :view) do
  before do
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('.ncce-mailing', text: 'Stay up to date')
  end

  it 'links to the Facebook page' do
    expect(rendered).to have_link('Like NCCE on Facebook', href: '#')
  end

  it 'links to the Twitter account' do
    expect(rendered).to have_link('Follow @WeAreComputing on Twitter', href: '#')
  end

  it('renders the correct button') do
    expect(rendered).to(have_css('.ncce-mailing__button', text: 'Get updates'))
  end

end
