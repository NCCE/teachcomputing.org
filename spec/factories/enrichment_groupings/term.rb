FactoryBot.define do
  factory :enrichment_groupings_term, class: EnrichmentGroupings::Term do
    title { 'title' }
    term_start { 10.days.ago }
    term_end { 10.days.from_now }
    programme
  end
end
