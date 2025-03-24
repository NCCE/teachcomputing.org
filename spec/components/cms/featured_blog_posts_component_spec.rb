require "rails_helper"

RSpec.describe Cms::FeaturedBlogPostsComponent, type: :component do
  context "when no posts" do
    before do
      stub_strapi_get_empty_collection_entity("blogs")
      render_inline(described_class.new(number_to_display: 5))
    end

    it "should show link to news" do
      expect(page).to have_css(".govuk-button.button.hero-button--home")
    end
  end

  context "when strapi errors" do
    before do
      stub_featured_posts_error
      render_inline(described_class.new(number_to_display: 5))
    end

    it "should show link to news" do
      expect(page).to have_css(".govuk-button.button.hero-button--home")
    end
  end

  context "when has posts" do
    before do
      stub_strapi_blog_collection
      render_inline(described_class.new(number_to_display: 5))
    end

    it "should show featured post" do
      expect(page).to have_css(".ncce-feat__main")
    end

    it "should show other posts" do
      expect(page).to have_css(".ncce-feat__panel", count: 4)
    end
  end

  context "when not show_main_feature" do
    before do
      stub_strapi_blog_collection
      render_inline(described_class.new(number_to_display: 5, show_main_feature: false))
    end

    it "should show other posts" do
      expect(page).to have_css(".ncce-feat__panel", count: 5)
    end
  end
end
