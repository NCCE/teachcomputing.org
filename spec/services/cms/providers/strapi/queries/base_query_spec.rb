require "rails_helper"

RSpec.describe Cms::Providers::Strapi::Queries::BaseQuery do
  it "should default resource_filter to slug" do
    expect(described_class.new(Cms::Collections::Blog).resource_filter).to eq("slug")
  end

  describe "#all_query" do
    let(:graphql_query) { described_class.new(Cms::Collections::Blog).all_query(1, 10) }

    it "should include resource name in all query when extended" do
      expect(graphql_query).to match(/blogs/)
    end

    it "should include pagination query" do
      expect(graphql_query).to match(/page: 1/)
      expect(graphql_query).to match(/pageSize: 10/)
    end

    it "should include all_fields" do
      expect(graphql_query).to match(/featuredImage/)
    end
  end

  describe "#single_query" do
    let(:single_query) { described_class.new(Cms::Collections::Blog).single_query("test-key") }

    it "should include resource name in all query when extended" do
      expect(single_query).to match(/title/)
      expect(single_query).to match(/content/)
    end

    it "should include filter" do
      expect(single_query).to include("filters: { slug: {eq: \"test-key\"}}")
    end
  end
end
