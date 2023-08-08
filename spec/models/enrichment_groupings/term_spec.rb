require 'rails_helper'

RSpec.describe EnrichmentGroupings::Term do
  subject { create(:enrichment_groupings_term) }

  it_behaves_like 'EnrichmentExamplelike'

  context 'when term_start is missing' do
    it 'should not be valid' do
      term.term_start = nil

      expect(term).to_not be_valid
    end
  end

  context 'when term_end is missing' do
    it 'should not be valid' do
      term.term_end = nil

      expect(term).to_not be_valid
    end
  end
end
