require 'rails_helper'

RSpec.describe('pages/home/_mailing', type: :view) do
  before do
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('.ncce-stay-in-touch__heading', text: 'Stay up to date')
  end

  it 'has a correct number of labels' do
    expect(rendered).to have_css('.ncce-stay-in-touch__label', count: 2)
  end

  it 'has a correct number of inputs' do
    expect(rendered).to have_css('.ncce-stay-in-touch__input', count: 2)
  end

  it 'has a twitter link' do
    expect(rendered).to have_link('Follow us on Twitter', href: /twitter.com\/WeAreComputing/)
  end

  it 'has a facebook link' do
    expect(rendered).to have_link('Like us on Facebook', href: /facebook.com\/WeAreComputing/)
  end

  it 'has a twitter icon' do
    expect(rendered).to have_xpath('//img[contains(@class, "ncce-link__icon")][contains(@alt, "Twitter logo")]')
  end
  
  it 'has a facebook icon' do
    expect(rendered).to have_xpath('//img[contains(@class, "ncce-link__icon")][contains(@alt, "Facebook logo")]')
  end

end
