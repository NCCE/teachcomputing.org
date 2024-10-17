FactoryBot.define do
  factory :i_belong, class: "Programmes::IBelong" do
    title { "I Belong: encouraging girls into computer science" }
    slug { "i-belong" }
    description { "Encouraging girls into computer science" }
    enrollable { true }
    dashboard_name { "I Belong" }
    programme_complete_counter { create(:programme_complete_counter, programme: instance) }

    trait :with_activity_groupings do
      after(:create) do |programme|
        create_list(:programme_activity_grouping, 3, :with_activities, programme_id: programme.id)
      end
    end
  end
end
