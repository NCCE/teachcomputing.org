require "rails_helper"

RSpec.describe("pages/home/index", type: :view) do
  context "has featured posts" do
    before do
      stub_featured_posts
      @featured_posts = Ghost.new.get_featured_posts
      render
    end

    it("renders the featured news section") do
      expect(rendered).to(have_css(".ncce-feat", count: 1))
    end
  end

  context "has 0 featured posts" do
    before do
      stub_featured_posts_error
      @featured_posts = Ghost.new.get_featured_posts
      render
    end

    it("doesn't render the news section") do
      expect(rendered).to(have_css(".ncce-news-and-updates", count: 0))
    end
  end
end
