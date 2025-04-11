FactoryBot.define do
  factory :activity do
    sequence(:title, 100) { |n| "activity#{n}" }
    sequence(:credit, 100) { |n| n }
    sequence(:slug, 100) { |n| "activity-#{n}" }
    sequence(:future_learn_course_uuid) { SecureRandom.uuid }
    sequence(:stem_course_template_no) { SecureRandom.uuid }
    category { "face-to-face" }
    provider { "stem-learning" }
    sequence(:stem_activity_code, 1000) { |n| "CP#{n}" }
    always_on { false }
    retired { false }
    self_verification_info { nil }
  end

  trait :cs_accelerator_diagnostic_tool do
    title { "Taken diagnostic tool" }
    slug { "subject-knowledge-diagnostic-tool" }
    category { "diagnostic" }
    provider { "system" }
    credit { 0 }
  end

  trait :stem_learning do
    title { "STEM" }
    provider { "stem-learning" }
    category { "face-to-face" }
  end

  trait :remote do
    title { "STEM" }
    provider { "stem-learning" }
    category { "face-to-face" }
    remote_delivered_cpd { true }
  end

  trait :future_learn do
    title { "FutureLearn" }
    provider { "future-learn" }
    category { "online" }
  end

  trait :my_learning do
    title { "MyLearning Moodle course" }
    provider { "stem-learning" }
    category { "online" }
  end

  trait :cs_accelerator_exam do
    slug { "subject-knowledge-assessment" }
    title { "CSA exam" }
    provider { "classmarker" }
    category { "assessment" }
  end

  trait :system do
    title { "system" }
    category { "action" }
    provider { "system" }
  end

  trait :user_removable do
    title { "user removable" }
    category { "online" }
    self_certifiable { "true" }
  end

  trait :community do
    title { "Community Activity" }
    slug { "community-activity" }
    category { "community" }
    provider { "cas" }
    description { "this is a community activity" }
    credit { 10 }
    self_verification_info { "Please provide a link to your contribution" }
    public_copy_evidence {
      [{
        brief: "brief: step 1",
        bullets: [
          "point 1",
          "point 2",
          "point 3"
        ]
      },
        {
          brief: "brief: step 2"
        },
        {
          brief: "brief: step 3",
          bullets: [
            "point 4",
            "point 5",
            "point 6"
          ]
        }]
    }
  end

  trait :community_no_evidence do
    title { "Community Activity" }
    slug { "community-activity" }
    category { "community" }
    provider { "cas" }
    description { "this is a community activity" }
    credit { 10 }
    self_verification_info { nil }
    public_copy_evidence { nil }
  end

  trait :community_5 do
    title { "Community Activity" }
    slug { "community-activity-5" }
    category { "community" }
    provider { "cas" }
    description { "this is a 5 credit community activity" }
    credit { 5 }
  end

  trait :community_20 do
    title { "Community Activity" }
    slug { "community-activity-20" }
    category { "community" }
    provider { "cas" }
    description { "this is a 20 credit community activity" }
    credit { 20 }
  end

  trait :community_bookable do
    title { "Community Activity" }
    slug { "community-activity" }
    category { "community" }
    provider { "cas" }
    description { "this is a community activity" }
    credit { 10 }
    self_verification_info { "Please provide a link to your contribution" }
    booking_programme_slug { "subject-knowledge" }
  end

  trait :online do
    category { "online" }
  end

  trait :with_course_video do
    course_video_url { "https://www.youtube.com/watch?v=6YLhMadoo6Y&list=PLwcV67XMdDdJT0TkvZo6cTDSR0uJgP3Ku" }
  end
end
