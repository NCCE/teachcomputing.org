require "rails_helper"

RSpec.describe CmsController do
  describe "GET #articles" do
    context "with a valid page" do
      before do
        stub_strapi_get_collection_entity("blog")
        get "/blog"
      end

      it "renders the template" do
        expect(response).to render_template("collection")
      end
    end
  end
end
