require 'rails_helper'

RSpec.describe CurriculumClient::Request do
  let(:url) { CurriculumClient::Connection::CURRICULUM_API_URL }

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

    it "rasies an error if a connection isn't possible" do
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
  end
end
