FactoryBot.define do
  factory :pathway do
    range { 1..10 }
    title { 'Pathway' }
    description { 'Pathway description' }
    sequence(:slug) { |n| "slug-#{n}" }
  end
end
