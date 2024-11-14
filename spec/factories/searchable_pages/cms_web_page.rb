FactoryBot.define do
  factory :searchable_pages_cms_web_page, class: "SearchablePages::CmsWebPage" do
    slug { Random.uuid }
    title { Faker::Lorem.sentence }
    excerpt { Faker::Lorem.paragraph }
    published_at { DateTime.now }
  end
end
