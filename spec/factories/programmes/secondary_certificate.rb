FactoryBot.define do
  factory :secondary_certificate, class: Programmes::SecondaryCertificate do
    title { "Secondary Certificate" }
    slug { "secondary-certificate" }
    description { "This is the Secondary programme" }
    enrollable { true }
    dashboard_name { "Teach secondary computing" }
    pathways { create_list(:pathway, 3) }
    programme_complete_counter { create(:programme_complete_counter, programme: instance) }
  end
end
