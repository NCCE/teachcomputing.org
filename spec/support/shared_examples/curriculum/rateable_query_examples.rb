require 'spec_helper'

RSpec.shared_examples_for 'rateable_query' do |context|
  describe '.add_positive_rating' do
    before do
      allow(described_class).to receive(:rate)
    end

    it 'calls .rate correctly for a positive rating' do
<<<<<<< HEAD
      described_class.add_positive_rating(id: 'an_id', stem_achiever_contact_no:
                                          'achieverno')
      expect(described_class)
        .to have_received(:rate)
        .with(context, nil, :positive, 'an_id', 'achieverno')
=======
      described_class.add_positive_rating(id: 'an_id', stem_achiever_contact_no: 'achieverno')
      expect(described_class)
        .to have_received(:rate)
        .with(nil, 'an_id', 'achieverno', "add_positive_#{context.downcase}_rating")
>>>>>>> 0341a1ecef3abe348d2014a052ac745e8c6872fa
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
<<<<<<< HEAD
        .with(context, nil, :negative, 'an_id', 'achieverno')
=======
        .with(nil, 'an_id', 'achieverno', "add_negative_#{context.downcase}_rating")
>>>>>>> 0341a1ecef3abe348d2014a052ac745e8c6872fa
    end
  end

  describe '.rate' do
    it 'creates a negative mutation query' do
<<<<<<< HEAD
      expect(described_class.rate(:lesson, 'id', :negative, 'an_id', 'achieverid')).to have_requested(:post, url)
=======
      expect(described_class.rate('id', 'an_id', 'achieverid', 'add_negative_lesson_rating')).to have_requested(:post, url)
>>>>>>> 0341a1ecef3abe348d2014a052ac745e8c6872fa
        .with(body: /addNegativeLessonRating\(id:\s\\"an_id\\",\suserStemAchieverContactNo:\s\\"achieverid\\"\)/)
    end

    it 'creates a positive mutation query' do
<<<<<<< HEAD
      expect(described_class.rate(:lesson, 'id', :positive, 'an_id', 'achieverid'))
=======
      expect(described_class.rate('id', 'an_id', 'achieverid', 'add_positive_lesson_rating'))
>>>>>>> 0341a1ecef3abe348d2014a052ac745e8c6872fa
        .to have_requested(:post, url)
        .with(body: /addPositiveLessonRating\(id:\s\\"an_id\\",\suserStemAchieverContactNo:\s\\"achieverid\\"\)/)
    end

    it 'fails to create a mutation for an unsupported polarity' do
<<<<<<< HEAD
      expect { described_class.rate(:lesson, 'id', :unsupported, 'an_id', 'achieverid') }.to raise_error(
=======
      expect { described_class.rate('id', 'an_id', 'achieverid', 'add_unsupported_lesson_rating') }.to raise_error(
>>>>>>> 0341a1ecef3abe348d2014a052ac745e8c6872fa
        Graphlient::Errors::ClientError, "Field 'addUnsupportedLessonRating' doesn't exist on type 'Mutation'"
      )
    end
  end
end
