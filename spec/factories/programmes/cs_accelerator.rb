FactoryBot.define do
  factory :cs_accelerator, :class => Programmes::CSAccelerator do
    title { 'Teach GCSE computer science' }
    slug { 'cs-accelerator' }
    description { 'This is the CSA programme' }
    enrollable { true }
  end
end
