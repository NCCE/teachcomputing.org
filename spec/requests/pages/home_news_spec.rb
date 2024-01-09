require "rails_helper"

RSpec.describe PagesController do
  describe "GET #home _news" do
    it "asks the browser not to sniff MIME types" do
      stub_featured_posts
      get root_path
      expect(response.headers["X-Content-Type-Options"]).to eq("nosniff")
    end

    it "asks browsers to always check for content updates" do
      stub_featured_posts
      get root_path
      expect(response.headers["cache-control"]).to eq("max-age=0, private, must-revalidate")
    end

    context "featured posts" do
      before do
        stub_featured_posts
        get root_path
      end

      it "assigns @featured_posts" do
        expect(assigns(:featured_posts)).to be_a(Array)
      end

      it "has one main feature" do
        expect(assigns(:main_feature)).to be_a(Hash)
      end

      it "has correct number of posts" do
        expect(assigns(:featured_posts).length).to eq(1)
      end
    end

    context "featured posts error" do
      before do
        stub_featured_posts_error
        get root_path
      end

      it "assigns @featured_posts" do
        expect(assigns(:featured_posts)).to be_a(Array)
      end

      it "has 0 posts" do
        expect(assigns(:featured_posts).length).to eq(0)
      end
    end
  end
end
