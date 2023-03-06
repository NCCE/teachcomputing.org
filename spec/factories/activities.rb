FactoryBot.define do
  factory :activity do
    sequence(:title, 100) { |n| "activity#{n}" }
    sequence(:credit, 100) { |n| n }
    sequence(:slug, 100) { |n| "activity-#{n}" }
    sequence(:future_learn_course_uuid) { SecureRandom.uuid }
    sequence(:stem_course_template_no) { SecureRandom.uuid }
    category { 'face-to-face' }
    provider { 'stem-learning' }
    sequence(:stem_activity_code) { |n| "CP#{n}" }
    always_on { false }
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

  trait :remote do
    title { 'STEM' }
    provider { 'stem-learning' }
    category { 'face-to-face' }
    remote_delivered_cpd { true }
  end

  trait :future_learn do
    title { 'future learn' }
    provider { 'future-learn' }
    category { 'online' }
  end

  trait :my_learning do
    title { 'MyLearning Moodle course' }
    provider { 'stem-learning' }
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

  trait :community_bookable do
    title { 'Community Activity' }
    slug { 'community-activity' }
    category { 'community' }
    provider { 'cas' }
    description { 'this is a community activity' }
    credit { 10 }
    self_verification_info { 'Please provide a link to your contribution' }
    booking_programme_slug { 'cs-accelerator' }
  end

  trait :online do
    category { 'online' }
  end
end
