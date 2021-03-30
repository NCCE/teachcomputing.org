require 'rails_helper'
require 'axe/rspec'

RSpec.describe('Teacher Landing pages', type: :system) do
  let(:cs_accelerator) { create(:programme, slug: 'cs-accelerator') }
  let(:secondary_certificate) { create(:programme, slug: 'secondary-certificate') }
  let(:primary_certificate) { create(:programme, slug: 'primary-certificate') }

  context 'Primary Teachers page' do
    before do
      primary_certificate
      visit primary_teachers_path
    end

    it 'is the correct page' do
      expect(page).to have_css('.govuk-heading-l', text: 'Inspiration and support for teaching primary computing')
    end

    it 'main is accessible' do
      expect(page).to be_accessible.within('#main-content')
    end
  end

  context 'Secondary Teachers page' do
    before do
      cs_accelerator
      secondary_certificate
      visit secondary_teachers_path
    end

    it 'is the correct page' do
      expect(page).to have_css('.govuk-heading-l', text: 'The essential toolkit for secondary computing teachers')
    end
  end
end
