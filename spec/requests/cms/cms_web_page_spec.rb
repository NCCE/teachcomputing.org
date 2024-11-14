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
  end

  describe "GET #web_page_clear" do
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
