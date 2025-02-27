require "rails_helper"

RSpec.describe PagesController do
  describe "GET #home _news" do
    it "asks the browser not to sniff MIME types" do
      stub_featured_posts
      stub_strapi_homepage
      get root_path
      expect(response.headers["X-Content-Type-Options"]).to eq("nosniff")
    end

    it "asks browsers to always check for content updates" do
      stub_featured_posts
      stub_strapi_homepage
      get root_path
      expect(response.headers["cache-control"]).to eq("max-age=0, private, must-revalidate")
    end
  end
end
