require "rails_helper"

RSpec.describe EnrichmentGroupings::Term do
  DATES_TO_TEST = [DateTime.new(2023, 12, 23), DateTime.new(2023, 7, 15), DateTime.new(2024, 12, 23), DateTime.new(2024, 7, 15), DateTime.new(2024, 2, 28), DateTime.new(2024, 2, 26)]
  subject { create(:enrichment_groupings_term) }

  it_behaves_like "EnrichmentExamplelike"

  context "when term_start is missing" do
    it "should not be valid" do
      subject.term_start = nil

      expect(subject).to_not be_valid
    end
  end

  context "when term_end is missing" do
    it "should not be valid" do
      subject.term_end = nil

      expect(subject).to_not be_valid
    end
  end

  describe "#is_current_term?" do
    DATES_TO_TEST.each do |date|
      context "when the date is #{date}" do
        around do |ex|
          travel_to(date) do
            ex.run
          end
        end

        context "when is comming soon" do
          subject { create(:enrichment_groupings_term, coming_soon: true) }

          it "should return true" do
            expect(subject.is_current_term?).to be true
          end
        end

        context "when is not comming soon" do
          context "when the curent date is in the range" do
            it "should return true" do
              expect(subject.is_current_term?).to be true
            end
          end

          context "when the curent date is not in the range" do
            subject { create(:enrichment_groupings_term, term_start: 10.days.from_now, term_end: 20.days.from_now) }

            it "should return false" do
              expect(subject.is_current_term?).to be false
            end
          end
        end
      end
    end
  end

  describe "#days_till_term" do
    DATES_TO_TEST.each do |date|
      context "when the date is #{date}" do
        around do |ex|
          travel_to(date) do
            ex.run
          end
        end

        context "when is current term" do
          it "returns 0" do
            expect(subject.days_till_term).to eq 0
          end
        end

        context "when current term is false" do
          context "when days till start is ahead in the year" do
            subject { create(:enrichment_groupings_term, term_start: 10.days.from_now, term_end: 20.days.from_now) }

            it "should return 10" do
              expect(subject.days_till_term).to eq 10
            end
          end

          context "when days till start is behind in the year" do
            subject { create(:enrichment_groupings_term, term_start: 2.days.ago, term_end: 1.days.ago) }

            it "should return 363" do
              expect(subject.days_till_term).to eq 363
            end
          end
        end
      end
    end
  end
end
