require "rails_helper"

RSpec.describe Cms::Providers::Strapi::GraphqlClient do
  let(:client) {
    described_class.new(schema_path: ENV["STRAPI_TEST_SCHEMA_PATH"])
  }

  it "calls all with query parameter adds filter" do
    stub_strapi_graphql_collection_query("blogs", Array.new(5) { Cms::Mocks::Collections::Blog.generate_raw_data })
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
    stub_strapi_graphql_query("blogs", Cms::Mocks::Collections::Blog.generate_raw_data(slug: "unpublished", publish_date: nil, published_at: nil))
    expect do
      client.one(Cms::Collections::Blog, "unpublished")
    end.to raise_error(ActiveRecord::RecordNotFound)
  end

  it "doesn't raise RecordNotFound for unpublished resource with preview" do
    stub_strapi_graphql_query("blogs", Cms::Mocks::Collections::Blog.generate_raw_data(slug: "unpublished", publish_date: nil, published_at: nil))
    response = client.one(Cms::Collections::Blog, "unpublished", preview: true)
    expect(response).to be_an_instance_of(Hash)
  end

  it "class all and returns mapped resource" do
    stub_strapi_graphql_collection_query("blogs", Array.new(5) { Cms::Mocks::Collections::Blog.generate_raw_data }, page: 1, page_size: 10)
    response = client.all(Cms::Collections::Blog, 1, 10, {})
    expect(response[:total_records]).to eq(5)
    expect(response[:page_size]).to eq(10)
    expect(response[:page_number]).to eq(1)
    expect(response[:resources]).to be_a Array
    expect(response[:resources].length).to eq(5)
  end

  context "with failing connection" do
    before do
      failing_connection = double("api")
      allow(failing_connection).to receive(:execute).and_raise(StandardError)
      allow(Cms::Providers::Strapi::GraphqlConnection).to receive(:api).and_return(failing_connection)
    end
    it "one raises RecordNotFound" do
      expect do
        client.one(Cms::Collections::Blog, "test")
      end.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "all raises RecordNotFound" do
      expect do
        client.all(Cms::Collections::Blog, 1, 50, {query: {tag: "ai"}})
      end.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  context "#clean_aliases" do
    let(:input) {
      {
        "__typename" => "ComponentBlocksTestBlock",
        "alias__test" => "somevalue",
        "not_aliased" => "another value"
      }
    }

    it "should return correct name for aliased version" do
      response = client.clean_aliases(input)
      expect(response).to have_key(:test)
      expect(response).to have_key(:not_aliased)
    end

    it "should not effect __typename" do
      response = client.clean_aliases(input)
      expect(response).to have_key(:__typename)
    end
  end
end
