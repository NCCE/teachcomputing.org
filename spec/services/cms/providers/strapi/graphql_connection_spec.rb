require "rails_helper"

RSpec.describe Cms::Providers::Strapi::GraphqlConnection do
  describe "#dump_schema" do
    it "should call GraphQL::Client.dump_schema" do
      expect(GraphQL::Client).to receive(:dump_schema)
      described_class.dump_schema(schema_path: ENV["STRAPI_TEST_SCHEMA_PATH"])
    end
  end
end
