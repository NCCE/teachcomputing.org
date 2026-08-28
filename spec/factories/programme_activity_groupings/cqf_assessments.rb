FactoryBot.define do
  factory :programme_activity_groupings_cqf_assessment, class: "ProgrammeActivityGroupings::CqfAssessment" do
    title { "Undertake the CQF assessment" }
    required_for_completion { 1 }
    sort_key { 0 }
    programme
    progress_bar_title { "Progress Bar Title" }
    sequence(:cms_slug) { |n| "programme-activity-grouping-cqf-assessment-#{n}" }

    trait :with_activities do
      after(:create) do |programme_activity_grouping|
        create :programme_activity, programme_activity_grouping: programme_activity_grouping, programme: programme_activity_grouping.programme
      end
    end
  end
end
