require "rails_helper"

RSpec.describe Cms::Providers::Strapi::Factories::QueryFactory do
  context "is a blog" do
    it "should have featured tag" do
      params = described_class.generate_parameters(Cms::Collections::Blog, featured: true)
      expect(params[:featured]).to eq({"$eq": true})
    end

    it "has a filter tag" do
      params = described_class.generate_parameters(Cms::Collections::Blog, tag: "ai")
      expect(params[:blog_tags]).to eq({slug: {:$eq => "ai"}})
    end
  end

  context "is not a blog" do
    it "has no featured tag" do
      params = described_class.generate_parameters(Cms::Collections::SimplePage, featured: true)
      expect(params[:featured]).to eq(nil)
    end
    it "has no filter tag" do
      params = described_class.generate_parameters(Cms::Collections::SimplePage, tag: "ai")
      expect(params[:blog_tags]).to eq(nil)
    end
  end
end
