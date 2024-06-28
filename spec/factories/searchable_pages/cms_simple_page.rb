FactoryBot.define do
  factory :searchable_pages_cms_simple_page, class: "SearchablePages::CmsSimplePage" do
    slug { Random.uuid }
    title { "I'm a title" }
    excerpt { "I'm a description" }
    published_at { DateTime.now }
  end
end
