FactoryBot.define do
  factory :a_level, class: "Programmes::ALevel" do
    title { "A level Computer Science subject knowledge" }
    slug { "a-level-certificate" }
    description { "A level Computer Science subject knowledge" }
    enrollable { true }
    dashboard_name { "A level subject knowledge" }
    programme_complete_counter { create(:programme_complete_counter, programme: instance) }

    trait :with_activity_groupings do
      after(:create) do |programme|
        create_list(:programme_activity_grouping, 3, :with_activities, programme_id: programme.id)
      end
    end
  end
end
