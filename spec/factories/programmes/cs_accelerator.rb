FactoryBot.define do
  factory :cs_accelerator, class: Programmes::CSAccelerator do
    title { "Key stage 3 and GCSE Computer Science certificate" }
    slug { "subject-knowledge" }
    description { "This is the CSA programme" }
    enrollable { true }
    programme_complete_counter { create(:programme_complete_counter, programme: instance) }
  end
end
