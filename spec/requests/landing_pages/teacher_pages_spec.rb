require 'rails_helper'

RSpec.describe LandingPagesController do
  let(:cs_accelerator) { create(:programme, slug: 'cs-accelerator') }
  let(:primary_certificate) { create(:programme, slug: 'primary-certificate') }

  describe '#primary_teachers' do
    before do
      primary_certificate
      get primary_teachers_path
    end

    it 'renders the correct template' do
      expect(response).to render_template('landing_pages/primary-teachers')
    end
  end

  describe '#secondary_teachers' do
    before do
      cs_accelerator
      get secondary_teachers_path
    end

    it 'renders the correct template' do
      expect(response).to render_template('landing_pages/secondary-teachers')
    end
  end
end
