require "spec_helper"

RSpec.shared_examples_for "rateable_query" do |context|
  let(:url) { CurriculumClient::Connection::CURRICULUM_APP_URL }

  describe ".add_positive_rating" do
    before do
      allow(described_class).to receive(:rate)
    end

    it "calls .rate correctly for a positive rating" do
      described_class.add_positive_rating(id: "an_id", stem_achiever_contact_no: "achieverno")
      expect(described_class)
        .to have_received(:rate)
        .with(nil, "an_id", "achieverno", "add_positive_#{context.downcase}_rating")
    end
  end

  describe ".add_negative_rating" do
    before do
      allow(described_class).to receive(:rate)
    end

    it "calls .rate correctly for a negative rating" do
      described_class.add_negative_rating(id: "an_id", stem_achiever_contact_no: "achieverno")
      expect(described_class)
        .to have_received(:rate)
        .with(nil, "an_id", "achieverno", "add_negative_#{context.downcase}_rating")
    end
  end

  describe ".rate" do
    it "creates a negative mutation query" do
      expect(described_class.rate("id", "an_id", "achieverid", "add_negative_lesson_rating")).to have_requested(:post, url)
        .with(body: /addNegativeLessonRating\(id:\s\\"an_id\\",\suserStemAchieverContactNo:\s\\"achieverid\\"\)/)
    end

    it "creates a positive mutation query" do
      expect(described_class.rate("id", "an_id", "achieverid", "add_positive_lesson_rating"))
        .to have_requested(:post, url)
        .with(body: /addPositiveLessonRating\(id:\s\\"an_id\\",\suserStemAchieverContactNo:\s\\"achieverid\\"\)/)
    end

    it "fails to create a mutation for an unsupported polarity" do
      expect { described_class.rate("id", "an_id", "achieverid", "add_unsupported_lesson_rating") }.to raise_error(
        Graphlient::Errors::ClientError, /Field 'addUnsupportedLessonRating' doesn't exist on type 'Mutation'/
      )
    end
  end
end
