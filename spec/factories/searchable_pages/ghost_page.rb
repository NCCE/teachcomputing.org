FactoryBot.define do
  factory :searchable_pages_ghost_page, class: "SearchablePages::GhostPage" do
    slug { Random.uuid }
    title { "I'm a title" }
    excerpt { "I'm a description" }
    published_at { DateTime.now }
  end
end
