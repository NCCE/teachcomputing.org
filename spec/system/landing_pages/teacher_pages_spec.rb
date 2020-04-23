require 'rails_helper'
require 'axe/rspec'

RSpec.describe('Teacher Landing pages', type: :system) do
  let(:cs_accelerator) { create(:programme, slug: 'cs-accelerator') }
  let(:primary_certificate) { create(:programme, slug: 'primary-certificate') }

  context 'Primary Teachers page' do
    before do
      primary_certificate
      visit primary_teachers_path
    end

    it 'is the correct page' do
      expect(page).to have_css('.govuk-heading-l', text: 'High-quality free computing activities for students of all ages')
    end

    it 'main is accessible' do
      expect(page).to be_accessible.within('#main-content')
    end
  end

  context 'Secondary Teachers page' do
    before do
      cs_accelerator
      visit secondary_teachers_path
    end

    it 'main is accessible' do
      expect(page).to be_accessible.within('#main-content').excluding('.axe-skip-a11y-test')
    end
  end

end
