FactoryBot.define do
  factory :primary_certificate, :class => Programmes::PrimaryCertificate do
    title { 'Teach primary computing' }
    slug { 'primary-certificate' }
    description { 'This is the Primary programme' }
    enrollable { true }
  end
end
