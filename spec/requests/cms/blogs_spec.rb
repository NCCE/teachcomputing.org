require "rails_helper"

RSpec.describe CmsController do
  describe "GET #articles" do
    context "with a valid page" do
      before do
        stub_strapi_blog_collection
        get "/blog"
      end

      it "renders the template" do
        expect(response).to render_template("collection")
      end
    end

    context "with valid tag" do
      before do
        stub_strapi_blog_collection_with_tag("ai")
        get "/blog", params: {tag: "ai"}
      end

      it "renders the template" do
        expect(response).to render_template("collection")
      end

      it "is passed the tag as a title" do
        expect(assigns(:title)).to eq("ai")
      end
    end
  end
end
