require "rails_helper"

RSpec.describe Cms::Providers::Strapi::Queries::BaseQuery do
  it "should default resource_filter to slug" do
    expect(described_class.new(Cms::Collections::Blog).resource_filter).to eq("slug")
  end

  describe "#all_query" do
    let(:graphql_query) { described_class.new(Cms::Collections::Blog).all_query(1, 10) }
    let(:webpage_query) { described_class.new(Cms::Collections::WebPage).all_query(1, 10) }

    it "should include resource name in all query when extended" do
      expect(graphql_query).to match(/blogs/)
    end

    it "should short when collection has sort" do
      expect(graphql_query).to match(/sort: "#{Cms::Collections::Blog.sort}"/)
    end

    it "should not sort when collection has no sort" do
      expect(webpage_query).not_to match(/sort:/)
    end

    it "should include pagination query" do
      expect(graphql_query).to match(/page: 1/)
      expect(graphql_query).to match(/pageSize: 10/)
    end

    it "should include all_fields" do
      expect(graphql_query).to match(/featuredImage/)
    end

    context "with filters" do
      it "featured for blogs" do
        query = described_class.new(Cms::Collections::Blog).all_query(1, 10, {featured: true})
        expect(query).to match(/filters:\s*{\s*featured:\s*{\s*eq:\s*true/)
      end

      it "tag for blogs" do
        query = described_class.new(Cms::Collections::Blog).all_query(1, 10, {tag: "ai"})
        expect(query).to match(/filters:\s*{\s*blog_tags:\s*{\s*slug:\s*{\s*eq:\s*"ai"/)
      end
    end
  end

  describe "#single_query" do
    let(:single_query) { described_class.new(Cms::Collections::Blog).single_query("test-key") }

    it "should include resource name in all query when extended" do
      expect(single_query).to match(/title/)
      expect(single_query).to match(/content/)
    end

    it "should include filter" do
      expect(single_query).to include("filters: { slug: { eq: \"test-key\" } }")
    end
  end
end
