FactoryBot.define do
  factory :searchable_page do
    title { "I'm a title" }
    excerpt { "I'm a description" }
    published_at { DateTime.now }
  end
end
