require 'rails_helper'
require 'axe/rspec'

RSpec.describe('Static pages') do
  let(:programme) { create(:programme, slug: 'cs-accelerator') }

  context 'when visiting the about page' do
    before do
      visit about_path
    end

    it 'is the correct page' do
      expect(page).to have_css('.hero-media-component__title', text: 'About us')
    end

    it 'main is accessible' do
      expect(page).to be_accessible.within('#main-content')
    end
  end

  context 'when visiting the accessibility statement page' do
    before do
      visit accessibility_statement_path
    end

    it 'is the correct page' do
      expect(page).to have_css('.govuk-heading-xl', text: 'Accessibility statement')
    end

    it 'main is accessible' do
      expect(page).to be_accessible.within('#main-content')
    end
  end

  context 'when visiting the getting involved page' do
    before do
      visit get_involved_path
    end

    it 'is the correct page' do
      expect(page).to have_content('Help us inspire the computing experts of the future')
    end

    it 'main is accessible' do
      expect(page).to be_accessible.within('#main-content')
    end
  end

  context 'when visitng the privacy page' do
    before do
      visit privacy_path
    end

    it 'is the correct page' do
      expect(page).to have_content('Privacy Notice')
    end

    it 'main is accessible' do
      expect(page).to be_accessible.within('#main-content')
    end
  end

  context 'when visiting the terms page' do
    before do
      visit terms_conditions_path
    end

    it 'is the correct page' do
      expect(page).to have_content('National Centre for Computing Education Terms and Conditions')
    end

    it 'main is accessible' do
      expect(page).to be_accessible.within('#main-content')
    end
  end

  context 'when triggering a 404 error' do
    before do
      visit '/404'
    end

    it 'is the correct page' do
      expect(page).to have_css('.govuk-heading-xl', text: 'Page not found')
    end

    it 'main is accessible' do
      expect(page).to be_accessible.within('#main-content')
    end
  end
end
