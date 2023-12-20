FactoryBot.define do
  factory :cs_accelerator, class: Programmes::CSAccelerator do
    title { 'KS3 and GCSE Computer Science subject knowledge certificate' }
    slug { 'subject-knowledge' }
    description { 'This is the CSA programme' }
    enrollable { true }
  end
end
