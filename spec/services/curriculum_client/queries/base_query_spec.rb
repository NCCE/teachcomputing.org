require 'spec_helper'

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
      expect(described_class.all(:yearGroup, 'id slug description units { id }')).to have_requested(:post, url)
        .with(body: /yearGroup\s\{\\n\s+id\\n\s+slug\\n\s+description\\n\s+units\s\{\\n\s+id\\n\s+\}\\n\s+\}\\n\}/)
    end
  end

  describe 'rating' do
    it 'creates a negative mutation query' do
      expect(described_class.rate(:lesson, 'id', :negative, 'an_id')).to have_requested(:post, url)
        .with(body: /addNegativeLessonRating\(id:\s\\"an_id\\"\)/)
    end

    it 'creates a positive mutation query' do
      expect(described_class.rate(:lesson, 'id', :positive, 'an_id')).to have_requested(:post, url)
        .with(body: /addPositiveLessonRating\(id:\s\\"an_id\\"\)/)
    end

    it 'fails to create a mutation for an unsupported polarity' do
      expect { described_class.rate(:lesson, 'id', :unsupported, 'an_id') }.to raise_error(
        Graphlient::Errors::ClientError, "Field 'addUnsupportedLessonRating' doesn't exist on type 'Mutation'"
      )
    end
  end
end
