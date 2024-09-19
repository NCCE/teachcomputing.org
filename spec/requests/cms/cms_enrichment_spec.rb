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
end
