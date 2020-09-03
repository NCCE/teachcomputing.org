require 'rails_helper'

RSpec.describe CurriculumClient::Queries::BaseQuery do
  let(:url) { CurriculumClient::Connection::CURRICULUM_API_URL }

  before do
    stub_a_valid_request
  end

  describe 'queries' do
    it 'pass the expected params' do
      expect(described_class.one(:keyStage, 'id', :slug, 'key-stage-0')).to have_requested(:post, url)
        .with(body: hash_including({ 'variables': { 'slug': 'key-stage-0' } }))

      expect(described_class.one(:keyStage, 'id', :id, 'an_id')).to have_requested(:post, url)
        .with(body: hash_including({ 'variables': { 'id': 'an_id' } }))
    end

    it 'use only the specified fields' do
      expect(described_class.all(:yearGroup, 'id slug units { id }')).to have_requested(:post, url)
        .with(body: /yearGroup\s\{\\n\s+id\\n\s+slug\\n\s+units\s\{\\n\s+id\\n\s+\}\\n\s+\}\\n\}/)
    end
  end
end
