require 'spec_helper'

RSpec.describe Curriculum::Connection do
  let(:file_cache) { ActiveSupport::Cache.lookup_store(:file_store, file_caching_path) }
  let(:cache) { Rails.cache }
  let(:url) {Curriculum::Connection::CURRICULUM_API_URL}
  let(:schema) {File.new('spec/support/curriculum/curriculum_schema.json').read}

  before do
    allow(Rails).to receive(:cache).and_return(file_cache)
    Rails.cache.clear
  end

  it 'throws if an incorrect schema is specified' do
    expect{described_class.connect('missing.json')}.to raise_error(Curriculum::Errors::SchemaLoadError)
  end

  it 'can load a schema' do
    stub_a_valid_schema_request
    client = described_class.connect
    expect(client.schema).to be_truthy
    expect(client.schema).to be_a Graphlient::Schema
  end

  it 'can load a schema from the cache' do
    stub = stub_request(:post, url)
    cache.write('curriculum_schema', schema)
    client = described_class.connect

    expect(stub).not_to have_been_requested
    expect(client.schema).to be_a Graphlient::Schema
  end
end
