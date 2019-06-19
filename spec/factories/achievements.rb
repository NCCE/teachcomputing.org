FactoryBot.define do
  factory :achievement do
    activity
    user

    factory :completed_achievement do
      after(:create) do |achievement|
        achievement.transition_to(:complete, { credit: 100 })
      end
    end
  end
end
