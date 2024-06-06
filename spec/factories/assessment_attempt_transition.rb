FactoryBot.define do
  factory :assessment_attempt_transition do
    association :assessment_attempt
    to_state { "commenced" }
    sort_key { 1 }
    most_recent { false }

    trait :most_recent do
      most_recent { true }
    end

    trait :passed do
      to_state { "passed" }
    end

    trait :failed do
      to_state { "failed" }
    end
  end
end
