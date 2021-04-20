FactoryBot.define do
  factory :achievement do
    activity
    user

    trait :with_supporting_evidence do
      after(:build) do |achievement|
        achievement.supporting_evidence.attach(
          io: File.open(
            Rails.root.join('spec', 'support', 'active_storage',
                            'supporting_evidence_test_upload.png')
          ), filename: 'test.png', content_type: 'image/png'
        )
      end
    end

    trait :online do
      activity { association :activity, :online }
    end

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

    factory :in_progress_achievement do
      after(:create) do |achievement|
        achievement.transition_to(:in_progress, { credit: 29 })
      end
    end
  end
end
