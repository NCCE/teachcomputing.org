require 'spec_helper'

RSpec.shared_examples_for 'rateable_query' do |context|
  describe '.add_positive_rating' do
    before do
      allow(described_class).to receive(:rate)
    end

    it 'calls .rate correctly for a positive rating' do
      described_class.add_positive_rating(id: 'an_id', stem_achiever_contact_no:
                                          'achieverno')
      expect(described_class)
        .to have_received(:rate)
        .with(context, nil, :positive, 'an_id', 'achieverno')
    end
  end

  describe '.add_negative_rating' do
    before do
      allow(described_class).to receive(:rate)
    end

    it 'calls .rate correctly for a negative rating' do
      described_class.add_negative_rating(id: 'an_id', stem_achiever_contact_no: 'achieverno')
      expect(described_class)
        .to have_received(:rate)
        .with(context, nil, :negative, 'an_id', 'achieverno')
    end
  end

  describe '.rate' do
    it 'creates a negative mutation query' do
      expect(described_class.rate(:lesson, 'id', :negative, 'an_id', 'achieverid')).to have_requested(:post, url)
        .with(body: /addNegativeLessonRating\(id:\s\\"an_id\\",\suserStemAchieverContactNo:\s\\"achieverid\\"\)/)
    end

    it 'creates a positive mutation query' do
      expect(described_class.rate(:lesson, 'id', :positive, 'an_id', 'achieverid'))
        .to have_requested(:post, url)
        .with(body: /addPositiveLessonRating\(id:\s\\"an_id\\",\suserStemAchieverContactNo:\s\\"achieverid\\"\)/)
    end

    it 'fails to create a mutation for an unsupported polarity' do
      expect { described_class.rate(:lesson, 'id', :unsupported, 'an_id', 'achieverid') }.to raise_error(
        Graphlient::Errors::ClientError, "Field 'addUnsupportedLessonRating' doesn't exist on type 'Mutation'"
      )
    end
  end
end
