require "rails_helper"

RSpec.describe CmsController do
  describe "GET #cms_post" do
    context "with a valid page" do
      before do
        stub_strapi_get_single_blog_post("blogs/funding",
          title: "Education and industry unite at key event championing gender equity in computer science")
        get "/blog/funding"
      end

      it "assigns @resource" do
        expect(assigns(:resource)).to be_a(Object)
      end

      it "@resource has a title" do
        expect(assigns(:resource).data_models.first.title).to eq("Education and industry unite at key event championing gender equity in computer science")
      end

      it "renders the template" do
        expect(response).to render_template("resource")
      end
    end

    context "invalid slug" do
      it "should raise error" do
        expect{
          get("/blog/not(avalid)page")
        }.to raise_error(ActiveRecord::RecordNotFound)
      end

      it "should raise error for sql attempt" do
        expect{
          get("/blog/#{CGI.escape("select from users where 1=1;")}")
        }.to raise_error(ActiveRecord::RecordNotFound)
      end

      it "should raise error for graphql attempt" do
        expect{
          get("/blog/#{CGI.escape("users { email }")}")
        }.to raise_error(ActiveRecord::RecordNotFound)
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

    context "with unpublished page" do
      before do
        stub_strapi_get_single_unpublished_blog_post("blogs/unpublished")
      end

      it "raised an error" do
        expect { get "/blog/unpublished" }.to raise_error(ActiveRecord::RecordNotFound)
      end

      it "renders page with preview parameter" do
        get "/blog/unpublished?preview=true"
        expect(response).to render_template("resource")
      end
    end
  end
end
