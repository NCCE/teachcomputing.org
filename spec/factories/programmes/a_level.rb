FactoryBot.define do
  factory :a_level, class: 'Programmes::ALevel' do
    title { 'A level subject knowledge' }
    slug { 'a-level' }
    description { 'A level subject knowledge' }
    enrollable { true }

    trait :with_activity_groupings do
      after(:create) do |programme|
        create_list(:programme_activity_grouping, 3, :with_activities, programme_id: programme.id)
      end
    end
  end
end

