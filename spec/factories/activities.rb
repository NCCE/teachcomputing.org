FactoryBot.define do
  factory :activity do
    sequence(:title, 100) { |n| "activity#{n}" }
    sequence(:credit, 100) { |n| n }
    sequence(:slug, 100) { |n| "activity-#{n}" }
    category { 'action' }
  end

  trait :created_ncce_account do
    title { 'Created NCCE account' }
    slug { 'created-ncce-account' }
    category { 'action' }
  end

  trait :diagnostic_tool do
    title { 'Downloaded diagnostic tool' }
    slug { 'downloaded-diagnostic-tool' }
    category { 'action' }
  end

  trait :cpd do
    category { 'cpd' }
  end
end
