require "rails_helper"

RSpec.describe CmsController do
  describe "GET #cms_page" do
    context "with a valid page" do
      before do
        stub_strapi_get_single_entity("privacy-notice")
        get "/privacy"
      end

      it "assigns @resource" do
        expect(assigns(:resource)).to be_a(Object)
      end

      it "@resource has a title" do
        expect(assigns(:resource).attributes[:title]).to eq("Test Page")
      end

      it "renders the template" do
        expect(response).to render_template("resource")
      end
    end

    context "with a missing page" do
      before do
        stub_missing_cms_page
      end

      it "raises an error" do
        expect { get "/eggs" }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "GET #clear_page_cache" do
    let(:ghost_mock) { instance_double(Ghost) }

    before do
      allow(Ghost).to receive(:new).and_return(ghost_mock)
      allow(ghost_mock).to receive(:clear_page_cache).and_return(nil)
    end

    context "with a cms page" do
      it "redirects to page" do
        get "/page-slug/refresh"
        expect(response).to redirect_to("/page-slug")
      end

      it "calls cache clear method" do
        get "/page-slug/refresh"
        expect(ghost_mock).to have_received(:clear_page_cache).with("page-slug")
      end
    end

    context "with a nested route page" do
      it "redirects to page" do
        get "/parent-slug/page-slug/refresh"
        expect(response).to redirect_to("/parent-slug/page-slug")
      end

      it "calls cache clear method" do
        get "/parent-slug/page-slug/refresh"
        expect(ghost_mock)
          .to have_received(:clear_page_cache)
          .with("parent-slug-page-slug")
      end
    end
  end
end
