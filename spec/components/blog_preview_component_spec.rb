require "rails_helper"

RSpec.describe BlogPreviewComponent, type: :component do
  context "with image" do
    before do
      render_inline(described_class.new(
        title: "Blog Preview",
        excerpt: "You will not believe what we discuss in this blog post",
        publish_date: DateTime.new(2024, 3, 18),
        featured_image: Cms::Models::ImageComponents::FeaturedImage.new(
          url: "http://media.teachcomputing.org/an-image.png",
          alt: "",
          caption: "",
          formats: {
            small: {
              url: "http://media.teachcomputing.org/an-image-small.png"
            }
          },
          size: :small
        ),
        slug: "blog-preview"
      ))
    end

    it "should render a small image" do
      expect(page).to have_css("img[src='http://media.teachcomputing.org/an-image-small.png']")
    end

    it "should show correct date" do
      expect(page).to have_text("18 MARCH 2024")
    end

    it "should display title" do
      expect(page).to have_css(".govuk-heading-s", text: "Blog Preview")
    end

    it "should display excerpt" do
      expect(page).to have_css(".govuk-body", text: "You will not believe what we discuss in this blog post")
    end
  end

  context "without image" do
    before do
      render_inline(described_class.new(
        title: "Blog Preview",
        excerpt: "You will not believe what we discuss in this blog post",
        publish_date: DateTime.new(2024, 3, 18),
        featured_image: nil,
        slug: "blog-preview"
      ))
    end

    it "should render placeholder" do
      expect(page).to have_css("img[src*='blog_cover_placeholder']")
    end
  end
end
