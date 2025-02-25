require "rails_helper"

RSpec.describe "rake strapi:update_graphql_schema", type: :task do
  before do
    @schema = File.new("spec/support/cms/providers/strapi/schema.json").read.freeze
    stub_strapi_schema
  end

  it "should write the schema to the file defined by STRAPI_TEST_SCHEMA_PATH" do
    expect(File).to receive(:write).with(ENV["STRAPI_TEST_SCHEMA_PATH"], @schema)
    task.execute
  end
end
