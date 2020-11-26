require 'rails_helper'

RSpec.describe LandingPagesController do
  let(:cs_accelerator) { create(:cs_accelerator) }
  let(:primary_certificate) { create(:primary_certificate) }
  let(:secondary_certificate) { create(:secondary_certificate) }

  describe '#primary_teachers' do
    before do
      primary_certificate
      get primary_teachers_path
    end

    it 'assigns programme' do
      expect(assigns(:programme)).to eq(primary_certificate)
    end

    it 'renders the correct template' do
      expect(response).to render_template('landing_pages/primary_teachers')
    end
  end

  describe '#secondary_teachers' do
    before do
      secondary_certificate
      cs_accelerator
      get secondary_teachers_path
    end

    it 'assigns cs accelerator' do
      expect(assigns(:cs_accelerator)).to eq(cs_accelerator)
    end

    it 'assigns secondary certifcate' do
      expect(assigns(:secondary_certificate)).to eq(secondary_certificate)
    end

    it 'renders the correct template' do
      expect(response).to render_template('landing_pages/secondary_teachers')
    end
  end
end
