require 'rails_helper'
require 'axe/rspec'

feature 'Home page' do

  before do
    stub_featured_posts
    visit root_path
  end

  scenario 'is correct' do
    expect(page).to have_content("Helping you\nteach computing")
  end

  scenario 'header is accessible' do
    expect(page).to be_accessible.within('header').skipping('aria-allowed-role')
  end

  scenario 'hero is accessible' do
    expect(page).to be_accessible.within '.ncce-hero'
  end
end
