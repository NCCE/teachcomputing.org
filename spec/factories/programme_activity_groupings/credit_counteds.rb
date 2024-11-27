FactoryBot.define do
  factory :programme_activity_groupings_credit_counted, class: "ProgrammeActivityGroupings::CreditCounted" do
    title { "A group name" }
    required_for_completion { 1 }
    sort_key { 1 }
    programme
    sequence(:cms_slug) { |n| "programme-activity-grouping-credited-#{n}" }

    trait :progress_bar_title do
      progress_bar_title { "Progress Bar Title" }
    end

    trait :with_activities do
      after(:create) do |programme_activity_grouping|
        create :programme_activity, programme_activity_grouping: programme_activity_grouping, programme: programme_activity_grouping.programme
      end
    end
  end
end
