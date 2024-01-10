FactoryBot.define do
  factory :searchable_pages_course, class: "SearchablePages::Course" do
    stem_activity_code { "CP321" }
    title { "I'm a title" }
    excerpt { "I'm a description" }
    published_at { DateTime.now }
  end
end
