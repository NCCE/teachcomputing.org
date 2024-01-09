require "rails_helper"

RSpec.describe SearchablePage, type: :model do
  describe ".search" do
    it "should search the excerpt and title for relevant records" do
      p1 = create(:searchable_page, title: "foo")
      p2 = create(:searchable_page, excerpt: "foo")
      p3 = create(:searchable_page, title: "foo bar")
      p4 = create(:searchable_page, excerpt: "foo bar")
      p5 = create(:searchable_page, title: "bar baz")
      p6 = create(:searchable_page, excerpt: "bar baz")

      expect(SearchablePage.search("foo")).to match_array [p1, p2, p3, p4]
    end
  end

  describe "#url" do
    it "should raise NotImplementedError" do
      page = create(:searchable_page)

      expect { page.url }.to raise_error(NotImplementedError)
    end
  end
end
