FactoryBot.define do
  factory :pathway do
    range { 1..10 }
    title { 'Pathway' }
    description { 'Pathway description' }
    pdf_link { 'https://example.com/pdf-link.pdf' }
    sequence(:slug) { |n| "slug-#{n}" }
  end
end
