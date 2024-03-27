require "rails_helper"

RSpec.describe EnrichmentGroupings::AllYear do
  subject { create(:enrichment_groupings_term) }

  it_behaves_like "EnrichmentExamplelike"
end
