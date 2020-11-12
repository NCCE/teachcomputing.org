FactoryBot.define do
  factory :programme_activity_grouping do
    title { 'A group name' }
    required_for_completion { 1 }
    sort_key { 1 }
    programme

    trait :with_activities do
      after(:create) do |programme_activity_grouping|
        create :programme_activity, programme_activity_grouping: programme_activity_grouping, programme: programme_activity_grouping.programme
      end
    end
  end
end
