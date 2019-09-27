FactoryBot.define do
  factory :cs_accelerator, :class => Programmes::CSAccelerator do
    title { 'CS Accelerator' }
    slug { 'cs-accelerator' }
    description { 'This is the CSA programme' }
    enrollable { true }
  end
end
