require 'rails_helper'

RSpec.describe('pages/i-belong', type: :view) do
  before do
    render
  end

  it 'has a title section' do 
    expect(rendered).to have_css('.govuk-heading-xl', text: 'I Belong: encouraging girls into computer science')
  end 

  it 'has a description section' do 
    expect(rendered).to have_content('We offer a curated package of training')
  end 

  it 'has a side image' do 
    expect(rendered).to have_css('.aside-component__image', count: 1)
  end 

  it 'has a title' do
    expect(rendered).to have_css('.govuk-heading-xl', text: 'I Belong: encouraging girls into computer science')
  end

  it 'shows 3 support cards' do
    expect(rendered).to have_css('.lp-support__card', count: 3)
  end

  it 'has 3 resource cards' do
    expect(rendered).to have_css('.non-bordered-card', count: 3)
  end
end
