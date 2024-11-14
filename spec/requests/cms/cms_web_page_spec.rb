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
  end
end
