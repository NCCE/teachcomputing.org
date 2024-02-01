FactoryBot.define do
  factory :searchable_pages_site_page, class: "SearchablePages::SitePage" do
    url { "/foobar" }
    title { "I'm a title" }
    excerpt { "I'm a description" }
    published_at { DateTime.now }
  end
end
