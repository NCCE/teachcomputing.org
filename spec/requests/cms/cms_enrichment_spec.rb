require "rails_helper"

RSpec.describe CmsController do
  describe "GET #show" do
    context "when primary" do
      let(:programme) { create(:primary_certificate) }

      before do
        stub_strapi_enrichment_page("primary-enrichment")
        get primary_enrichment_path
      end

      it "renders the correct template" do
        expect(response).to render_template("resource")
      end
    end

    context "when secondary" do
      before do
        stub_strapi_enrichment_page("secondary-enrichment")
        get secondary_enrichment_path
      end

      it "renders the correct template" do
        expect(response).to render_template("resource")
      end
    end
  end

  describe "cache clearing" do
    before do
      allow(Cms::Collections::EnrichmentPage).to receive(:clear_cache).and_return(nil)
      get "/primary-enrichment/refresh"
    end

    context "with a cms page" do
      it "redirects to page" do
        expect(response).to redirect_to("/primary-enrichment")
      end

      it "calls cache clear method" do
        expect(Cms::Collections::EnrichmentPage).to have_received(:clear_cache).with("primary-enrichment")
      end
    end
  end
end
