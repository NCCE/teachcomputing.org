require 'spec_helper'

RSpec.describe Curriculum::Queries::BaseQuery do
  let(:url) { Curriculum::Connection::CURRICULUM_API_URL }

  before do
    stub_a_valid_schema_request
  end

  describe 'queries' do
    it 'are performed with expected params' do
      expect(described_class.one('keyStage', ['id'], 'slug', 'key-stage-0')).to have_requested(:post, url)
        .with(body: hash_including({ 'variables': { 'slug': 'key-stage-0' } }))

      expect(described_class.one('keyStage', ['id'], 'id', 'an_id')).to have_requested(:post, url)
        .with(body: hash_including({ 'variables': { 'id': 'an_id' } }))
    end

    it 'only queries the requested fields' do
      pending "should add this, it's currently not a utilised code path so of lower priority"
      raise
    end
  end
end
