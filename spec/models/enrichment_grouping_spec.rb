require 'rails_helper'

RSpec.describe EnrichmentGrouping, type: :model do
  subject { create(:enrichment_grouping) }

  it_behaves_like 'EnrichmentExamplelike'
end
