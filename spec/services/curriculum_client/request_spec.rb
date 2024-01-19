require "rails_helper"

RSpec.describe CurriculumClient::Request do
  let(:url) { CurriculumClient::Connection::CURRICULUM_APP_URL }
  let(:null_error_response_json) { File.new("spec/support/curriculum/responses/key_stage_null_error.json").read }
  let(:other_error_response_json) { File.new("spec/support/curriculum/responses/key_stage_other_error.json").read }

  describe "request" do
    before do
      stub_a_valid_schema_request
    end

    it "raises an error if an unexpected or empty client instance is passed" do
      expect { described_class.run(query: nil, client: {}) }
        .to raise_error(CurriculumClient::Errors::ConnectionError)
    end

    it "raises an error for an unparsed query" do
      client = CurriculumClient::Connection.connect(ENV.fetch("CURRICULUM_TEST_SCHEMA_PATH"))

      query = <<~GRAPHQL
        query {}
      GRAPHQL

      expect { described_class.run(query:, client:) }
        .to raise_error(CurriculumClient::Errors::UnparsedQuery)
    end

    it "doesn't block other execution errors" do
      client = CurriculumClient::Connection.connect(ENV.fetch("CURRICULUM_TEST_SCHEMA_PATH"))

      response = JSON.parse(other_error_response_json, object_class: OpenStruct)

      stub_request(:post, url)
        .to_raise(ActionController::RoutingError.new(response))

      query = <<~GRAPHQL
        query {
          keyStage(slug: "nonsense") {
            id
          }
        }
      GRAPHQL

      expect { described_class.run(query: client.parse(query), client:) }
        .to raise_error(ActionController::RoutingError)
    end
  end
end
