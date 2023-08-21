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
  end

  describe '#days_till_term' do
  end
end
