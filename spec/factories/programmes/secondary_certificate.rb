FactoryBot.define do
  factory :secondary_certificate, class: Programmes::SecondaryCertificate do
    title { "Secondary Certificate" }
    slug { "secondary-certificate" }
    description { "This is the Secondary programme" }
    enrollable { true }
    pathways { create_list(:pathway, 3) }
  end
end
