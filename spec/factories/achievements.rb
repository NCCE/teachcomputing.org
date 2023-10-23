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

    trait :face_to_face do
      activity { association :activity, :stem_learning, title: 'Face to face activity' }
    end

    trait :remote do
      activity { association :activity, :remote, title: 'Remote activity' }
    end

    trait :remote_no_activity_code do
      activity { association :activity, :remote, title: 'Remote activity', stem_activity_code: nil }
    end

    trait :future_learn do
      activity { association :activity, :future_learn, title: 'FutureLearn online activity' }
    end

    trait :online do
      activity { association :activity, :my_learning, title: 'MyLearning online activity' }
    end

    trait :my_learning do
      online
    end

    trait :community do
      activity { association :activity, :community, title: 'Commmunity activity' }
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

    factory :drafted_achievement do
      after(:create) do |achievement|
        achievement.transition_to :drafted
      end
    end
  end
end
