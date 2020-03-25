require 'rails_helper'

RSpec.describe('pages/gender-balance', type: :view) do
  before do
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('.govuk-heading-l', text: 'Gender Balance in Computing')
  end

  it 'has a intro section' do
    expect(rendered).to have_css('.govuk-body-l', count: 2)
  end

  it 'has images' do
    expect(rendered).to have_css('img', count: 5)
  end

  it 'has an aside section' do
    expect(rendered).to have_css('.ncce-aside', text: 'Get involved in this landmark programme')
  end
end
