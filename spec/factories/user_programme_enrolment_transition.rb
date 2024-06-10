FactoryBot.define do
  factory :user_programme_enrolment_transition do
    user_programme_enrolment
    to_state { "enrolled" }
    sort_key { 1 }
    most_recent { false }

    trait :most_recent do
      most_recent { true }
    end

    trait :unenrolled do
      to_state { "unenrolled" }
    end

    trait :pending do
      to_state { "pending" }
    end

    trait :complete do
      to_state { "complete" }
    end
  end
end
