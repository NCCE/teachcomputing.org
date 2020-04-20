require 'rails_helper'

RSpec.describe('pages/home-teaching', type: :view) do
  before do
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('.govuk-heading-l', text: 'Home Learning')
  end

  it 'has a hero image' do
    expect(rendered).to have_css('.text-photo-hero__block--photo', count: 1)
  end

  it 'has a k4 ey stage sections' do
    expect(rendered).to have_css('.shadow_card', count: 4)
  end



end
