FactoryBot.define do
  factory :activity do
    sequence(:title, 100) { |n| "activity#{n}" }
    sequence(:credit, 100) { |n| n }
  end
end
