require "rails_helper"

RSpec.describe Cms::Providers::Strapi::GraphqlClient do
  let(:client) {
    described_class.new(schema_path: ENV["STRAPI_TEST_SCHEMA_PATH"])
  }

  it "calls all with query parameter adds filter" do
    stub_strapi_graphql_collection_query("blogs", Array.new(5) { Cms::Mocks::Blog.generate_raw_data })
    response = client.all(Cms::Collections::Blog, 1, 50, {query: {tag: "ai"}})
    expect(response[:resources]).to be_an_instance_of(Array)
  end

  it "raises RecordNotFound for missing resource" do
    stub_strapi_graphql_query_missing("blogs")
    expect do
      client.one(Cms::Collections::Blog)
    end.to raise_error(ActiveRecord::RecordNotFound)
  end

  it "raises RecordNotFound for unpublished resource" do
    stub_strapi_graphql_query("blogs", Cms::Mocks::Blog.generate_raw_data(slug: "unpublished", publish_date: nil, published_at: nil))
    expect do
      client.one(Cms::Collections::Blog, "unpublished")
    end.to raise_error(ActiveRecord::RecordNotFound)
  end

  it "doesn't raise RecordNotFound for unpublished resource with preview" do
    stub_strapi_graphql_query("blogs", Cms::Mocks::Blog.generate_raw_data(slug: "unpublished", publish_date: nil, published_at: nil))
    response = client.one(Cms::Collections::Blog, "unpublished", preview: true)
    expect(response).to be_an_instance_of(Hash)
  end

  it "class all and returns mapped resource" do
    stub_strapi_graphql_collection_query("blogs", Array.new(5) { Cms::Mocks::Blog.generate_raw_data })
    response = client.all(Cms::Collections::Blog, 1, 10, {})
    expect(response[:total_records]).to eq(5)
    expect(response[:page_size]).to eq(10)
    expect(response[:page_number]).to eq(1)
    expect(response[:resources]).to be_a Array
    expect(response[:resources].length).to eq(5)
  end
end
