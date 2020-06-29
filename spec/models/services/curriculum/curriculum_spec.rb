require 'spec_helper'

RSpec.describe Curriculum do
  fit 'throws if an incorrect schema is specified' do
    expect {described_class::Connection.connect('missing.json')}.to raise_error(Curriculum::Errors::SchemaLoadError)
  end

  it 'can load the schema' do
    client = described_class::Connection.connect
    expect(client.schema).to be_truthy
    expect(client.schema).to be_a Graphlient::Schema
  end

  it "throws if an unexpected or empty client instance is passed" do
    query = <<~GRAPHQL
      query {}
    GRAPHQL

    expect {described_class::Request.run(query, {}, described_class)}
      .to raise_error(Curriculum::Errors::ConnectionError, "Invalid or missing Graphlient::Client, unable to connect")
  end

  it "throws if it can't connect" do
    url = Curriculum::Connection::CURRICULUM_API_URL
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
    expect {described_class::Request.run(query)}
      .to raise_error(Curriculum::Errors::ConnectionError, "Unable to connect to: #{url}")
  end
end
