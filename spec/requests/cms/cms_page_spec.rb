require "rails_helper"

RSpec.describe CmsController do
  describe "GET #cms_page" do
    context "with a valid page" do
      before do
        stub_strapi_get_single_simple_page("simple-pages/privacy")
        get "/privacy"
      end

      it "assigns @resource" do
        expect(assigns(:resource)).to be_a(Object)
      end

      it "@resource has a title" do
        expect(assigns(:resource).data_models.first.title).to eq("Test Page")
      end

      it "renders the template" do
        expect(response).to render_template("resource")
      end
    end
  end

  describe "GET #clear_page_cache" do
    before do
      allow(Cms::Collections::Blog).to receive(:clear_cache).and_return(nil)
    end

    context "with a cms page" do
      it "redirects to page" do
        get "/page-slug/refresh"
        expect(response).to redirect_to("/page-slug")
      end

      it "calls cache clear method" do
        get "/page-slug/refresh"
        expect(Cms::Collections::Blog).to have_received(:clear_cache).with("page-slug")
      end
    end

    context "with a nested route page" do
      it "redirects to page" do
        get "/parent-slug/page-slug/refresh"
        expect(response).to redirect_to("/parent-slug/page-slug")
      end

      it "calls cache clear method" do
        get "/parent-slug/page-slug/refresh"
        expect(Cms::Collections::Blog)
          .to have_received(:clear_cache)
          .with("parent-slug-page-slug")
      end
    end
  end
end
