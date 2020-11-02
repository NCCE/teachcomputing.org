FactoryBot.define do
  factory :programme do
    sequence(:title, 100) { |n| "programme-#{n}" }
    sequence(:slug, 100) { |n| "programme-#{n}" }
    description { 'This is a programme to learn some cool 101' }
    enrollable { true }

    factory :primary_certificate_programme do
      title { 'Primary Certificate' }
      slug { 'primary-certificate' }
      description { 'This is the primary certificate programme' }
      enrollable { true }
      type { Programmes::PrimaryCertificate }
    end

    factory :cs_accelerator_certificate_programme do
      title { 'CS Accelerator' }
      slug { 'cs-accelerator' }
      description { 'This is the CS accelerator programme' }
      enrollable { true }
      type { Programmes::CSAccelerator }
    end
  end
end
