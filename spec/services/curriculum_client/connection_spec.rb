require 'rails_helper'

RSpec.describe CurriculumClient::Connection do
  let(:file_cache) { ActiveSupport::Cache.lookup_store(:file_store, file_caching_path) }
  let(:cache) { Rails.cache }
  let(:url) { CurriculumClient::Connection::CURRICULUM_API_URL }
  let(:schema) { File.new('spec/support/curriculum/curriculum_schema.json').read }

  describe 'schema' do
    before do
      allow(Rails).to receive(:cache).and_return(file_cache)
      Rails.cache.clear
    end

    it 'raises an error if it fails to load' do
      expect { described_class.connect('missing.json') }.to raise_error(CurriculumClient::Errors::SchemaLoadError)
    end

    it 'can load' do
      stub_a_valid_schema_request_strict
      client = described_class.connect
      expect(client.schema).to be_truthy
      expect(client.schema).to be_a Graphlient::Schema
    end

    it 'is written to the cache' do
      stub_a_valid_schema_request_strict
      described_class.connect
      cached_schema = Rails.cache.fetch('curriculum_schema')
      expect(JSON.parse(cached_schema)).to eq(JSON.parse(schema))
    end

    it 'can be retrieved from the cache' do
      cache.write('curriculum_schema', schema)
      client = described_class.connect
      # The strange parsing here is to match the formatting
      expect(JSON.parse(client.schema.to_json)).to eq(JSON.parse(schema))
    end
  end
end
