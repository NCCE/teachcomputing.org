FactoryBot.define do
  factory :activity do
    sequence(:title, 100) { |n| "activity#{n}" }
    sequence(:credit, 100) { |n| n }
  end

  trait :created_ncce_account do
    title { 'Created NCCE account' }
    slug { 'created-ncce-account' }
  end

  trait :diagnostic_tool do
    title { 'Downloaded diagnostic tool' }
    slug { 'downloaded-diagnostic-tool' }
  end
end
