require "rails_helper"

RSpec.describe EnrichmentController do
  describe "GET #show" do
    context "when primary" do
      let(:programme) { create(:primary_certificate) }

      before do
        programme
        get primary_enrichment_path
      end

      it "shows the page" do
        expect(response).to render_template("enrichment/show")
      end
    end

    context "when secondary" do
      let(:programme) { create(:secondary_certificate) }

      before do
        programme
        get secondary_enrichment_path
      end

      it "shows the page" do
        expect(response).to render_template("enrichment/show")
      end
    end
  end
end
