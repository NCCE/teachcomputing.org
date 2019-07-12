require 'rails_helper'
require 'axe/rspec'

RSpec.describe('Static pages', type: :system) do
  let(:programme) { create(:programme, slug: 'cs-accelerator') }

  context 'Home page' do
    before do
      stub_featured_posts
      visit root_path
    end

    # it 'page is accessible' do
    #   # Axe browser tool will check the entire page
    #   expect(page).to be_accessible
    # end

    it 'is the correct page' do
      expect(page).to have_content("Helping you\nteach computing")
    end

    xit 'header is accessible' do
      expect(page).to be_accessible.within('header')
    end

    it 'page is accessible' do
      expect(page).to be_accessible.within('#main-content').skipping('aria-allowed-role')
    end

    xit 'footer is accessible' do
      expect(page).to be_accessible.within('footer')
    end
  end

  context 'About page' do
    before do
      visit about_path
    end

    it 'is the correct page' do
      expect(page).to have_css('.govuk-heading-l', text: 'About Us')
    end

    it 'main is accessible' do
      expect(page).to be_accessible.within('#main-content').skipping('aria-allowed-role')
    end
  end

  context 'Accessibility statement page' do
    before do
      visit accessibility_statement_path
    end

    it 'is the correct page' do
      expect(page).to have_css('.govuk-heading-l', text: 'Accessibility statement')
    end

    it 'main is accessible' do
      expect(page).to be_accessible.within('#main-content').skipping('aria-allowed-role')
    end
  end

  context 'Bursary page' do
    before do
      visit bursary_path
    end

    it 'is the correct page' do
      expect(page).to have_content('Bursary entitlement')
    end

    it 'main is accessible' do
      expect(page).to be_accessible.within('#main-content').skipping('aria-allowed-role')
    end
  end

  context 'Certification page' do
    before do
      visit certification_path
    end

    it 'is the correct page' do
      expect(page).to have_css('.govuk-heading-l', text: 'Certification')
    end

    it 'main is accessible' do
      expect(page).to be_accessible.within('#main-content').skipping('aria-allowed-role')
    end
  end

  context 'CS Accelerator page' do
    before do
      programme
      visit cs_accelerator_path
    end

    it 'is the correct page' do
      expect(page).to have_css('.govuk-heading-m', text: 'Welcome to the Computer Science Accelerator Programme')
    end

    it 'main is accessible' do
      expect(page).to be_accessible.within('#main-content').skipping('aria-allowed-role')
    end
  end

  context 'Contact page' do
    before do
      visit contact_path
    end

    it 'is the correct page' do
      expect(page).to have_content('Contact')
    end

    it 'main is accessible' do
      expect(page).to be_accessible.within('#main-content').skipping('aria-allowed-role')
    end
  end

  context 'Get involved page' do
    before do
      visit get_involved_path
    end

    it 'is the correct page' do
      expect(page).to have_content('Inspiring the computing experts of the future')
    end

    it 'main is accessible' do
      expect(page).to be_accessible.within('#main-content').skipping('aria-allowed-role')
    end
  end

  context 'Hubs page' do
    before do
      visit hubs_path
    end

    it 'is the correct page' do
      expect(page).to have_content('Network of Computing Hubs')
    end

    it 'main is accessible' do
      expect(page).to be_accessible.within('#main-content').skipping('aria-allowed-role')
    end
  end

  context 'Login page' do
    before do
      visit login_path
    end

    it 'is the correct page' do
      expect(page).to have_content('Create an account')
    end

    it 'main is accessible' do
      expect(page).to be_accessible.within('#main-content').skipping('aria-allowed-role')
    end
  end

  context 'Offer page' do
    before do
      visit offer_path
    end

    it 'is the correct page' do
      expect(page).to have_content('What We Offer')
    end

    it 'main is accessible' do
      expect(page).to be_accessible.within('#main-content').skipping('aria-allowed-role')
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
      expect(page).to be_accessible.within('#main-content').skipping('aria-allowed-role')
    end
  end

  context 'Terms page' do
    before do
      visit terms_conditions_path
    end

    it 'is the correct page' do
      expect(page).to have_content('Terms and Conditions National Centre for Computing Education')
    end

    it 'main is accessible' do
      expect(page).to be_accessible.within('#main-content').skipping('aria-allowed-role')
    end
  end

  context '404 page' do
    before do
      visit '/404'
    end

    it 'is the correct page' do
      expect(page).to have_css('.govuk-heading-l', text: 'Page not found')
    end

    it 'main is accessible' do
      expect(page).to be_accessible.within('#main-content').skipping('aria-allowed-role')
    end
  end
end
