FactoryBot.define do
  factory :programme_activity_groupings_professional_development_activity, class: "ProgrammeActivityGroupings::ProfessionalDevelopmentActivity" do
    title { "Implement and evaluate your professional development" }
    required_for_completion { 1 }
    sort_key { 1 }
    programme
    progress_bar_title { "Progress Bar Title" }
    sequence(:cms_slug) { |n| "programme-activity-grouping-pd-activity-#{n}" }

    trait :with_activities do
      after(:create) do |programme_activity_grouping|
        create :programme_activity, programme_activity_grouping: programme_activity_grouping, programme: programme_activity_grouping.programme
      end
    end
  end
end
