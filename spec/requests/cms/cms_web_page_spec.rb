require "rails_helper"

RSpec.describe CmsController do
  describe "GET #cms_page" do
    context "with a valid page" do
      before do
        stub_strapi_get_single_web_page("web-pages/privacy")
        get "/privacy"
      end

      it "assigns @resource" do
        expect(assigns(:resource)).to be_a(Object)
      end

      it "@resource has a title" do
        expect(assigns(:resource).data_models.first.title).to eq("Test web page")
      end

      it "@resource has an intro title" do
        expect(assigns(:resource).data_models.first.intro_text).to eq("Welcome to the test web page.")
      end

      it "renders the template" do
        expect(response).to render_template("resource")
      end
    end
  end

  describe "GET #clear_page_cache" do
    before do
      allow(Cms::Collections::WebPage).to receive(:clear_cache).and_return(nil)
    end

    context "with a cms page" do
      it "redirects to page" do
        get "/page-slug/refresh"
        expect(response).to redirect_to("/page-slug")
      end

      it "calls cache clear method" do
        get "/page-slug/refresh"
        expect(Cms::Collections::WebPage).to have_received(:clear_cache).with("page-slug")
      end
    end
  end
end
