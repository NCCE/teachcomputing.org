require 'rails_helper'

RSpec.describe EnrichmentGroupings::Term do
  subject { create(:enrichment_groupings_term) }

  it_behaves_like 'EnrichmentExamplelike'

  context 'when term_start is missing' do
    it 'should not be valid' do
      subject.term_start = nil

      expect(subject).to_not be_valid
    end
  end

  context 'when term_end is missing' do
    it 'should not be valid' do
      subject.term_end = nil

      expect(subject).to_not be_valid
    end
  end

  describe '#is_current_term?' do
    context 'when is comming soon' do
      subject { create(:enrichment_groupings_term, coming_soon: true) }

      it 'should return true' do
        expect(subject.is_current_term?).to be true
      end
    end

    context 'when is not comming soon' do
      context 'when the curent date is in the range' do
        it 'should return true' do
          expect(subject.is_current_term?).to be true
        end
      end

      context 'when the curent date is not in the range' do
        subject { create(:enrichment_groupings_term, term_start: 10.days.from_now, term_end: 20.days.from_now) }

        it 'should return false' do
          expect(subject.is_current_term?).to be false
        end
      end
    end
  end

  describe '#days_till_term' do
    context 'when is current term' do
      it 'returns 0' do
        expect(subject.days_till_term).to eq 0
      end
    end

    context 'when current term is false' do
      context 'when days till start is ahead in the year' do
        subject { create(:enrichment_groupings_term, term_start: 10.days.from_now, term_end: 20.days.from_now) }

        it 'should return 9' do
          expect(subject.days_till_term).to eq 9
        end
      end

      context 'when days till start is behind in the year' do
        subject { create(:enrichment_groupings_term, term_start: 2.days.ago, term_end: 1.days.ago) }

        it 'should return 363' do
          expect(subject.days_till_term).to eq 363
        end
      end
    end
  end
end
