require 'rails_helper'

RSpec.describe('components/_footer', type: :view) do
  before do
    render
  end

  it 'has a twitter link' do
    expect(rendered).to have_link('Twitter', href: /twitter.com\/WeAreComputing/)
  end

  it 'has a facebook link' do
    expect(rendered).to have_link('Facebook', href: /facebook.com\/WeAreComputing/)
  end

  it 'has a twitter icon' do
    expect(rendered).to have_xpath('//img[contains(@class, "ncce-link__icon--footer")][contains(@alt, "Twitter logo")]')
  end
  
  it 'has a facebook icon' do
    expect(rendered).to have_xpath('//img[contains(@class, "ncce-link__icon--footer")][contains(@alt, "Facebook logo")]')
  end

end
