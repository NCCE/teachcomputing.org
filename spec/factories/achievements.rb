FactoryBot.define do
  factory :achievement do
    activity
    user

    factory :completed_achievement do
      after(:create) do |achievement|
        achievement.transition_to(:complete)
      end
    end
  end
end
