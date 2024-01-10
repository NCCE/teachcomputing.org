require "rails_helper"

RSpec.describe AssetEndpointController do
  describe "#css_endpoint" do
    context "css_redirect" do
      before do
        get "/external/assets/ncce.css"
      end

      it "redirects" do
        expect(response.code).to eq("302")
      end

      it "redirects to the application CSS" do
        expect(response.headers["Location"]).to match(/packs-test\/css\/application-([A-Za-z0-9]+)\.css/)
      end
    end
  end
end
