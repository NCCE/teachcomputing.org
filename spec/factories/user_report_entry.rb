FactoryBot.define do
  factory :user_report_entry do
    sequence(:programme_slug) { |n| "programme-#{n}" }
    sequence(:user_stem_user_id) { |n| "user-stem-user-id-#{n}" }

    user_email { "user@example.com" }
    user_enrolled { true }
    enrolled_at { Time.zone.now }
    last_active_at { Time.zone.now - 1.day }
    completed_cpd_component { false }
    completed_certificate { false }
    pending_certificate { false }
    completed_first_community_component { false }
    completed_second_community_component { false }
  end
end
