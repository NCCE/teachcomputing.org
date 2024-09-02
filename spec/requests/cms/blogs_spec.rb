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

  describe "GET #clear_page_cache" do
    before do
      allow(Cms::Collections::Blog).to receive(:clear_cache).and_return(nil)
    end

    context "with a blog page" do
      it "redirects to page" do
        get "/blog/page-slug/refresh"
        expect(response).to redirect_to("/blog/page-slug")
      end

      it "calls cache clear method" do
        get "/blog/page-slug/refresh"
        expect(Cms::Collections::Blog).to have_received(:clear_cache).with("page-slug")
      end
    end
  end
end
