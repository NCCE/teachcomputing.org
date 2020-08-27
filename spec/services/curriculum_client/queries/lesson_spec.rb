require 'rails_helper'

RSpec.describe CurriculumClient::Queries::Lesson do
  let(:url) { CurriculumClient::Connection::CURRICULUM_API_URL }

  before do
    stub_a_valid_schema_request
  end

  it 'creates valid queries' do
    expect { described_class.all }.not_to raise_error
    expect { described_class.one('some_id') }.not_to raise_error
  end

  describe '.add_positive_rating' do
    before do
      allow(described_class).to receive(:rate)
    end

    it 'calls .rate correctly' do
      described_class.add_positive_rating(id: 'an_id', stem_achiever_contact_no:
                                          'achieverno')
      expect(described_class)
        .to have_received(:rate)
        .with(:lesson, nil, :positive, 'an_id', 'achieverno')
    end
  end

  describe '.add_negative_rating' do
    before do
      allow(described_class).to receive(:rate)
    end

    it 'calls .rate correctly for a negative rating' do
      described_class.add_negative_rating(id: 'an_id', stem_achiever_contact_no:
                                          'achieverno')
      expect(described_class)
        .to have_received(:rate)
        .with(:lesson, nil, :negative, 'an_id', 'achieverno')
    end
  end
end
