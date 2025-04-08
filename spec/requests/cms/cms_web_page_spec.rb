require "rails_helper"

RSpec.describe CmsController do
  describe "GET #web_page_resource" do
    context "valid slug" do
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

    context "invalid slug" do
      it "should raise error" do
        expect {
          get("/not(avalid)page")
        }.to raise_error(ActiveRecord::RecordNotFound)
      end

      it "should raise error for sql attempt" do
        expect {
          get("/#{CGI.escape("select from users where 1=1;")}")
        }.to raise_error(ActiveRecord::RecordNotFound)
      end

      it "should raise error for graphql attempt" do
        expect {
          get("/#{CGI.escape("users { email }")}")
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "GET #web_page_resource/refresh" do
    before do
      stub_strapi_web_page("primary-early-careers")
    end

    it "redirects to original page" do
      get "/primary-early-careers/refresh"
      expect(response).to redirect_to("/primary-early-careers")
    end

    it "reloads page cache" do
      expect(Cms::Collections::WebPage).to receive(:clear_cache).with("primary-early-careers")
      get "/primary-early-careers/refresh"
    end
  end
end
