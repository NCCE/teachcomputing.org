FactoryBot.define do
  factory :programme do
    sequence(:title, 100) { |n| "programme-#{n}" }
    sequence(:slug, 100) { |n| "programme-#{n}" }
    description { 'This is a programme to learn some cool 101' }
    enrollable { true }

    factory :primary_certificate_programme do
      title { 'Primary Certificate Programme' }
      slug { 'primary-certificate' }
    end

    factory :cs_accelerator_programme do
      title { 'CS Accelerator Programme' }
      slug { 'cs-accelerator' }
    end
  end
end
