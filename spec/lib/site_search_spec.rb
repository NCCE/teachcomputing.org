require "rails_helper"

RSpec.describe SiteSearch do
  describe ".search" do
    it "it should return the most relevant results first when order is not provided" do
      close = create(:searchable_pages_cms_blog, title: "close")
      closeish = create(:searchable_pages_cms_blog, title: "close ish")
      create(:searchable_pages_cms_blog, title: "not near")

      results = SiteSearch.search("close")

      expect(results).to match_array [close, closeish]
    end

    it "it should return the most newest results first when newest order is provided" do
      close = create(:searchable_pages_cms_blog, title: "close", published_at: 2.year.ago)
      closeish = create(:searchable_pages_cms_blog, title: "close ish", published_at: 1.years.ago)
      create(:searchable_pages_cms_blog, title: "not near", published_at: 1.day.ago)

      results = SiteSearch.search("close", order: :published_newest)

      expect(results).to eq [closeish, close]
    end

    it "it should return the most oldest results first when oldest order is provided" do
      close = create(:searchable_pages_cms_blog, title: "close", published_at: 1.year.ago)
      closeish = create(:searchable_pages_cms_blog, title: "close ish", published_at: 2.years.ago)
      create(:searchable_pages_cms_blog, title: "not near", published_at: 1.day.ago)

      results = SiteSearch.search("close", order: :published_oldest)

      expect(results).to eq [closeish, close]
    end
  end
end
