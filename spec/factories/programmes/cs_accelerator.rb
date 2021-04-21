FactoryBot.define do
  factory :cs_accelerator, :class => Programmes::CSAccelerator do
    title { 'Teach GCSE computer science' }
    slug { 'cs-accelerator' }
    description { 'This is the CSA programme' }
    enrollable { true }
    credly_badge_template_id { '00cd7d3b-baca-442b-bce5-f20666ed591b' }
  end
end
