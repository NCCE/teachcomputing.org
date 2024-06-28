FactoryBot.define do
  factory :searchable_pages_cms_blog, class: "SearchablePages::CmsBlog" do
    slug { Random.uuid }
    title { "I'm a title" }
    excerpt { "I'm a description" }
    published_at { DateTime.now }
  end
end
