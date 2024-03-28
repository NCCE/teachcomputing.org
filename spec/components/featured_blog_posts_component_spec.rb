require "rails_helper"

RSpec.describe FeaturedBlogPostsComponent, type: :component do
  context "when no posts" do
    before do
      stub_strapi_get_empty_collection_entity("blogs")
      render_inline(described_class.new(number_to_display: 5))
    end

    it "should show link to news" do
      expect(page).to have_css(".govuk-button.button.hero-button--home")
    end
  end

  context "when has posts" do
    before do
      stub_strapi_get_collection_entity("blogs")
      render_inline(described_class.new(number_to_display: 5))
    end

    it "should show featured post" do
      expect(page).to have_css(".ncce-feat__main")
    end

    it "should show other posts" do
      expect(page).to have_css(".ncce-feat__panel", count: 4)
    end
  end
end
