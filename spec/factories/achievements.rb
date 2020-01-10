FactoryBot.define do
  factory :achievement do
    activity
    user

    factory :completed_achievement do
      after(:create) do |achievement|
        achievement.transition_to(:complete, { credit: 100 })
      end
    end

    factory :dropped_achievement do
      after(:create) do |achievement|
        achievement.transition_to(:dropped)
      end
    end

    factory :step_1_achievement do
      after(:create) do |achievement|
        achievement.transition_to(:step_1, { credit: 29 })
      end
    end

    factory :step_2_achievement do
      after(:create) do |achievement|
        achievement.transition_to(:step_2, { credit: 59 })
      end
    end
  end
end
