FactoryBot.define do
  factory :questionnaire_response_transition do
    questionnaire_response
    to_state { "in_progress" }
    sort_key { 1 }
    most_recent { false }

    trait :most_recent do
      most_recent { true }
    end

    trait :complete do
      to_state { "complete" }
    end
  end
end
