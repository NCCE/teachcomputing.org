require "rails_helper"

RSpec.describe CmsController do
  describe "GET #cms_page" do
    describe "GET #web_page_resource" do
      before do
        stub_strapi_web_page("primary-early-careers")
        get "/primary-early-careers"
      end
      it "assigns @resource" do
        expect(assigns(:resource)).to be_a(Object)
      end
      it "renders the template" do
        expect(response).to render_template("resource")
      end
    end

    describe "GET #cms_page/refresh" do
      before do
        stub_strapi_web_page("primary-early-careers")
      end

      it "redirects to original page" do
        get "/primary-early-careers/refresh"
        expect(response).to redirect_to("/primary-early-careers")
      end

      it "reloads aside cache" do
        expect(Cms::Collections::AsideSection).to receive(:clear_cache)
        get "/primary-early-careers/refresh"
      end

      it "reloads page cache" do
        expect(Cms::Collections::WebPage).to receive(:clear_cache).with("primary-early-careers")
        get "/primary-early-careers/refresh"
      end
    end

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

      # Temporarily removed whilst working on other Strapi components
      # it "@resource has an intro title" do
      #   expect(assigns(:resource).data_models.first.intro_text).to eq("Welcome to the test web page.")
      # end

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
