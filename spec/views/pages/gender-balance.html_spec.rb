require 'rails_helper'

RSpec.describe('pages/gender-balance', type: :view) do
  before do
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('.govuk-heading-l', text: 'Gender Balance in Computing')
  end

  it 'has a intro section' do
    expect(rendered).to have_css('.govuk-body-l', count: 1)
  end

  it 'has 4 images' do
    expect(rendered).to have_css('img', count: 4)
  end

  it '2 grey boxes' do
    expect(rendered).to have_css('.padded-box', count: 2)
  end

  it 'has an aside section' do
    expect(rendered).to have_css('.ncce-aside', text: 'Sign up for our newsletter')
  end

  it 'has a newsletter button' do
    expect(rendered).to have_link('Sign up for our newsletter', href: 'https://raspberrypi.us9.list-manage.com/subscribe?u=54fbc2c9ac9d9dd634725107a&id=400611fc51')
  end

  it 'has a learn more button' do
    expect(rendered).to have_link('Discover our research articles', href: 'https://blog.teachcomputing.org/tag/gbic-article/')
  end
end
