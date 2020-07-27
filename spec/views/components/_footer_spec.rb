require 'rails_helper'

RSpec.describe('components/_footer', type: :view) do
  before do
    render
  end

  it 'has a bursaries link' do
    expect(rendered).to have_link('Bursaries', href: '/bursary')
  end

  it 'has a contact link' do
    expect(rendered).to have_link('Email', href: 'mailto:info@teachcomputing.org')
  end

  it 'has a courses link' do
    expect(rendered).to have_link('Courses', href: '/courses')
  end

  it 'has a resources link' do
    expect(rendered).to have_link('Teaching resources', href: '/resources')
  end

  it 'has a news link' do
    expect(rendered).to have_link('News', href: 'https://blog.teachcomputing.org/tag/news/')
  end

  it 'has a privacy link' do
    expect(rendered).to have_link('Privacy', href: '/privacy')
  end

  it 'has a terms and conditions link' do
    expect(rendered).to have_link('Terms and Conditions', href: '/terms-conditions')
  end

  it 'has a press link' do
    expect(rendered).to have_link('Press', href: 'https://blog.teachcomputing.org/tag/press/')
  end

  it 'has an accessibility statement link' do
    expect(rendered).to have_link('Accessibility', href: '/accessibility-statement')
  end

  it 'has an about link' do
    expect(rendered).to have_link('About Us', href: '/about')
  end

  it 'has a get involved link' do
    expect(rendered).to have_link('Get Involved', href: '/get-involved')
  end

  it 'has a pedagogy link' do
    expect(rendered).to have_link('Pedagogy', href: '/pedagogy')
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
