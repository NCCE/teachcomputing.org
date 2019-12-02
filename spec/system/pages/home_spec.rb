require 'rails_helper'
require 'axe/rspec'

RSpec.describe('Static pages', type: :system) do
  before do
    stub_featured_posts
    visit root_path
  end

  it 'is the correct page' do
    expect(page).to have_content("Helping you\nteach computing")
  end

  it 'header is accessible' do
    expect(page).to be_accessible.within('header')
  end

  it 'page is accessible' do
    expect(page).to be_accessible.within('#main-content').excluding('.hero-video--home')
  end

  it 'footer is accessible' do
    expect(page).to be_accessible.within('footer')
  end
end
