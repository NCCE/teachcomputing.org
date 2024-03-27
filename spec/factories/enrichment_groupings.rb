FactoryBot.define do
  factory :enrichment_grouping do
    title { "title" }
    programme { create(:programme) }
  end
end
