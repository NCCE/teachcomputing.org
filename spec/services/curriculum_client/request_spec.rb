require 'rails_helper'

RSpec.describe CurriculumClient::Request do
  let(:url) { CurriculumClient::Connection::CURRICULUM_API_URL }
  let(:key_stage_null_json_response) { File.new('spec/support/curriculum/responses/key_stage_null.json').read }

  describe 'request' do
    before do
      stub_a_valid_schema_request
    end

    it 'raises an error if an unexpected or empty client instance is passed' do
      expect { described_class.run(nil, {}, described_class) }
        .to raise_error(CurriculumClient::Errors::ConnectionError)
    end

    it 'raises an error for an unparsed query' do
      client = CurriculumClient::Connection.connect

      query = <<~GRAPHQL
        query {}
      GRAPHQL

      expect { described_class.run(query, client) }
        .to raise_error(CurriculumClient::Errors::UnparsedQuery)
    end

    it "raises an error if a connection isn't possible" do
      client = CurriculumClient::Connection.connect

      stub_request(:post, url)
        .to_raise(Errno::ECONNREFUSED)

      query = <<~GRAPHQL
        query {
          keyStages {
            id
            title
            description
          }
        }
      GRAPHQL
      expect { described_class.run(client.parse(query), client) }
        .to raise_error(CurriculumClient::Errors::ConnectionError, /Unable to connect to/)
    end

    it 'raises an error for an invalid record' do
      client = CurriculumClient::Connection.connect

      # response_obj = JSON.parse(key_stage_null_json_response)
      # error = Graphlient::Errors::ExecutionError.new(response_obj)
      # error = GraphQL::Client::Response.new(response_obj)

      details = double('details')
      allow(details).to receive(:details).and_return({})

      data = double('data')
      allow(data).to receive(:errors).and_return(details)

      error = double('error')
      allow(error).to receive(:data).and_return(data)
      allow(error).to receive(:original_hash).and_return(JSON.parse(key_stage_null_json_response))

      stub_request(:post, url)
        .to_raise(Graphlient::Errors::ExecutionError.new(error))

      query = <<~GRAPHQL
        query {
          keyStage(slug: "nonsense") {
            id
          }
        }
      GRAPHQL

      expect { described_class.run(client.parse(query), client) }
        .to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
