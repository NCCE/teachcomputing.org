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

  it 'writes the schema to the cache' do
    stub_a_valid_schema_request
    described_class.connect
    cached_schema = Rails.cache.fetch('curriculum_schema')
    expect(JSON.parse(cached_schema)).to eq(JSON.parse(schema))
  end

  it 'retrieves the schema from the cache' do
    cache.write('curriculum_schema', schema)
    client = described_class.connect
    # The strange parsing here is to match the formatting
    expect(JSON.parse(client.schema.to_json)).to eq(JSON.parse(schema))
  end
end
