FactoryBot.define do
  factory :enrichment_entry do
    title { 'title' }
    title_url { 'https://google.com' }
    body { 'body' }
    enrichment_grouping { create(:enrichment_groupings_all_year, programme: create(:programme)) }
  end
end
