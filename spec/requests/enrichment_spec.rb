require 'rails_helper'

RSpec.describe EnrichmentController do

  describe 'GET #show' do

    context 'when primary' do
      let(:programme) { create(:primary_certificate) }

      before do
        programme
        get enrichment_path(slug: programme.slug)
      end

      it 'shows the page' do
        expect(response).to render_template('enrichment/show')
      end
    end

    context 'when secondary' do
      let(:programme) { create(:secondary_certificate) }

      before do
        programme
        get enrichment_path(slug: programme.slug)
      end

      it 'shows the page' do
        expect(response).to render_template('enrichment/show')
      end
    end
  end

end
