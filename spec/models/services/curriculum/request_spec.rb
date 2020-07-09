require 'rails_helper'

RSpec.describe Curriculum::Request do
  let(:url) { Curriculum::Connection::CURRICULUM_API_URL }

  describe 'request' do
    before do
      stub_a_valid_schema_request
    end

    it 'raises an error if an unexpected or empty client instance is passed' do
      query = <<~GRAPHQL
        query {}
      GRAPHQL

      expect { described_class.run(query, {}, described_class) }
        .to raise_error(Curriculum::Errors::ConnectionError, 'Invalid or missing Graphlient::Client, unable to connect')
    end

    it "rasies an error if a connection isn't possible" do
      client = Curriculum::Connection.connect

      # The next request should fail
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
      expect { described_class.run(query, {}, client) }
        .to raise_error(Curriculum::Errors::ConnectionError, "Unable to connect to: #{url}")
    end
  end
end
