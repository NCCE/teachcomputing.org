require "rails_helper"

RSpec.describe CmsController do
  describe "GET #cms_post" do
    context "with a valid page" do
      before do
        stub_strapi_get_single_entity("blogs/funding")
        get "/blog/funding"
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
        stub_strapi_not_found("blogs/eggs")
      end

      it "raises an error" do
        expect { get "/blog/eggs" }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
