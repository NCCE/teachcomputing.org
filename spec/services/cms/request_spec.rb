require "rails_helper"

RSpec.describe Cms::Request do
  context "with strapi as provider" do
    before do
      stub_const("ENV",
        {
          "CMS_PROVIDER" => "strapi",
          "STRAPI_API_KEY" => "strapi",
          "STRAPI_URL" => "http://strapi.teachcomputing.rpfdev.com/api"
        })
    end

    it "should return a blog collection" do
      stub_strapi_get_collection_entity("blogs")
      response = Cms::Request.all(Cms::Collections::Blog, 1, 10, {})
      expect(response[:resources].length).to eq(2)
      expect(response[:page]).to eq(1)
    end

    it "should return a single record" do
      stub_strapi_get_single_entity("privacy-notice")
      response = Cms::Request.one(Cms::Pages::PrivacyNotice, {})
      expect(response[:id]).to eq(1)
    end
  end

  context "invalid provider given" do
    before do
      stub_const("ENV",
        {
          "CMS_PROVIDER" => "",
          "STRAPI_API_KEY" => "strapi",
          "STRAPI_URL" => "http://strapi.teachcomputing.rpfdev.com/api"
        })
    end

    it "should raise error" do
      expect do
        Cms::Request.all(Cms::Collections::Blog, 1, 10, {})
      end.to raise_error(StandardError)
    end
  end
end
