FactoryBot.define do
  factory :activity do
    sequence(:title, 100) { |n| "activity#{n}" }
    sequence(:credit, 100) { |n| n }
    sequence(:slug, 100) { |n| "activity-#{n}" }
    category { 'action' }
    provider { 'stem-learning' }
  end

  trait :registered_with_national_centre do
    title { 'Registered with the National Centre' }
    slug { 'registered-with-the-national-centre' }
    category { 'action' }
    provider { 'system' }
  end

  trait :diagnostic_tool do
    title { 'Taken diagnostic tool' }
    slug { 'diagnostic-tool' }
    category { 'action' }
    provider { 'system' }
  end

  trait :cpd do
    category { 'cpd' }
  end

  trait :future_learn do
    title { 'future learn' }
    provider { 'future-learn' }
  end

  trait :system do
    title { 'system' }
    category { 'action' }
    provider { 'system' }
  end

  trait :user_removable do
    title { 'user removable' }
    category { 'cpd' }
    self_certifiable { 'true' }
  end
end
