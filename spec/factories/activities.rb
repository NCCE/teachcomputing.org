FactoryBot.define do
  factory :activity do
    sequence(:title, 100) { |n| "activity#{n}" }
    sequence(:credit, 100) { |n| n }
    sequence(:slug, 100) { |n| "activity-#{n}" }
    sequence(:future_learn_course_uuid, 100) { |n| "future_learn_course_uuid-#{n}" }
    sequence(:stem_course_template_no, 100) { |n| "stem_course_template_no-#{n}" }
    category { 'face-to-face' }
    provider { 'stem-learning' }
  end

  trait :registered_with_national_centre do
    title { 'Registered with the National Centre' }
    slug { 'registered-with-the-national-centre' }
    category { 'action' }
    provider { 'system' }
  end

  trait :cs_accelerator_diagnostic_tool do
    title { 'Taken diagnostic tool' }
    slug { 'cs-accelerator-diagnostic-tool' }
    category { 'diagnostic' }
    provider { 'system' }
    credit { 0 }
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

  trait :community do
    title { 'Community Activity' }
    slug { 'community-activity' }
    category { 'community' }
    provider { 'cas' }
    description { 'this is a community activity' }
    credit { 10 }
    self_verification_info { 'Please provide a link to your contribution' }
  end

  trait :community_5 do
    title { 'Community Activity' }
    slug { 'community-activity-5' }
    category { 'community' }
    provider { 'cas' }
    description { 'this is a 5 credit community activity' }
    credit { 5 }
  end

  trait :community_20 do
    title { 'Community Activity' }
    slug { 'community-activity-20' }
    category { 'community' }
    provider { 'cas' }
    description { 'this is a 20 credit community activity' }
    credit { 20 }
  end
end
