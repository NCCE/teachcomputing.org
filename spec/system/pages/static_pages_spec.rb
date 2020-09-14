require 'rails_helper'
require 'axe/rspec'

RSpec.describe('Static pages', type: :system) do
  let(:programme) { create(:programme, slug: 'cs-accelerator') }

  context 'About page' do
    before do
      visit about_path
    end

    it 'is the correct page' do
      expect(page).to have_css('.govuk-heading-xl', text: 'About Us')
    end

    it 'main is accessible' do
      expect(page).to be_accessible.within('#main-content')
    end
  end

  context 'Accessibility statement page' do
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

  context 'CS Accelerator page' do
    before do
      programme
      visit cs_accelerator_path
    end

    it 'is the correct page' do
      expect(page).to have_css('.govuk-heading-m', text: 'Welcome to Computer Science Accelerator')
    end

    # it 'main is accessible' do
    #   expect(page).to be_accessible.within('#main-content')
    # end
  end

  context 'Get involved page' do
    before do
      visit get_involved_path
    end

    it 'is the correct page' do
      expect(page).to have_content('Inspiring the computing experts of the future')
    end

    it 'main is accessible' do
      expect(page).to be_accessible.within('#main-content')
    end
  end

  context 'Privacy page' do
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

  context 'Terms page' do
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

  context '404 page' do
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
