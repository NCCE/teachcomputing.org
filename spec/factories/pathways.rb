FactoryBot.define do
  factory :pathway do
    range { 1..10 }
    title { "Pathway" }
    description { "Pathway description" }
    programme
  end
end
