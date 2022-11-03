FactoryBot.define do
  factory :assessment_attempt do
    assessment
    user
    accepted_conditions { true }

    factory :failed_assessment_attempt do
      after(:create) do |assessment_attempt|
        assessment_attempt.transition_to(:failed)
      end
    end

    factory :failed_assessment_attempt_from_before do
      after(:create) do |assessment_attempt|
        assessment_attempt.transition_to(:failed)
        assessment_attempt.last_transition.update(created_at: 50.hours.ago, updated_at: 50.hours.ago)
      end
    end

    factory :completed_assessment_attempt do
      after(:create) do |assessment_attempt|
        assessment_attempt.transition_to(:passed)
      end
    end

  end
end
