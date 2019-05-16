FactoryBot.define do
  factory :activity do
    sequence(:title, 100) { |n| "activity#{n}" }
    sequence(:credit, 100) { |n| n }
    sequence(:slug, 100) { |n| "activity-#{n}" }
    category { 'face-to-face' }
    provider { 'stem-learning' }
  end

  trait :registered_with_national_centre do
    title { 'Registered with the National Centre' }
    slug { 'registered-with-the-national-centre' }
    category { 'action' }
    provider { 'system' }
  end

  trait :diagnostic_tool do
    title { 'Downloaded diagnostic tool' }
    slug { 'downloaded-diagnostic-tool' }
    category { 'action' }
    provider { 'system' }
  end

  trait :stem_learning do
    title { 'STEM' }
    provider { 'stem-learning' }
    category { 'face-to-face' }
  end

  trait :future_learn do
    title { 'future learn' }
    provider { 'future-learn' }
    category { 'online' }
  end

  trait :cs_accelerator_exam do
    slug { 'cs-accelerator-assessment' }
    title { 'CSA exam' }
    provider { 'classmarker' }
    category { 'assessment' }
  end

  trait :system do
    title { 'system' }
    category { 'action' }
    provider { 'system' }
  end

  trait :user_removable do
    title { 'user removable' }
    category { 'online' }
    self_certifiable { 'true' }
  end
end
