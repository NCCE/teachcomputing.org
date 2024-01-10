FactoryBot.define do
  factory :programme do
    sequence(:title, 100) { |n| "programme-#{n}" }
    sequence(:slug, 100) { |n| "programme-#{n}" }
    description { "This is a programme to learn some cool 101" }
    enrollable { true }

    trait :with_badge do
      badge { association :badge }
    end
  end
end
