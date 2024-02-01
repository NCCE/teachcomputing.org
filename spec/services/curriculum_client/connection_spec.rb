require "rails_helper"

RSpec.describe CurriculumClient::Connection do
  describe "schema" do
    it "can load" do
      stub_a_valid_schema_request_strict
      client = described_class.connect(ENV.fetch("CURRICULUM_TEST_SCHEMA_PATH"))
      expect(client.schema).to be_truthy
      expect(client.schema).to be_a Graphlient::Schema
    end
  end
end
