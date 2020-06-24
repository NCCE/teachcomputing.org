require 'spec_helper'

RSpec.describe Curriculum do
  it 'throws if an incorrect schema is specified' do
    expect {described_class.connect('missing.json')}.to raise_error(Curriculum::SchemaLoadError)
  end

  it 'can load the schema' do
    client = described_class.connect
    expect(client.schema).to be_truthy
    expect(client.schema).to be_a Graphlient::Schema
  end

  it "throws if it can't connect" do
    url = Curriculum::CURRICULUM_API_URL
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
    expect {described_class.request(query)}
      .to raise_error(Curriculum::ConnectionError, "Unable to connect to: #{url}")
  end
end
