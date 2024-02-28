FactoryBot.define do
  factory :primary_certificate, class: "Programmes::PrimaryCertificate" do
    title { "Teach primary computing" }
    slug { "primary-certificate" }
    description { "This is the Primary programme" }
    enrollable { true }
    pathways { create_list(:pathway, 3) }
    programme_complete_counter { create(:programme_complete_counter, programme: instance) }

    trait :with_activity_groupings do
      after(:create) do |programme|
        create_list(:programme_activity_grouping, 3, :with_activities, programme_id: programme.id)
      end
    end
  end
end
