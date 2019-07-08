require 'rails_helper'
require 'axe/rspec'

RSpec.describe('Home page', type: :system) do
  before do
    stub_featured_posts
    visit root_path
  end

  it 'is the correct page' do
    expect(page).to have_content("Helping you\nteach computing")
  end

  xit 'header is accessible' do
    expect(page).to be_accessible.within('header')
  end

  it 'main is accessible' do
    expect(page).to be_accessible.within '#main-content'
  end

  xit 'footer is accessible' do
    expect(page).to be_accessible.within 'footer'
  end

end
