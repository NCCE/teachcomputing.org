require "rails_helper"

RSpec.describe BannerComponent, type: :component do
  context "with left align image" do
    before do
      render_inline(described_class.new(
        title: "Banner title",
        text: "Some random text",
        image: {
          url: "media/images/test/image.png",
          alt: ""
        },
        background_color: "purple",
        link: "http://www.example.com"
      ))
    end

    it "should have container" do
      expect(page).to have_css(".govuk-width-container")
    end

    it "should default to two thirds for content" do
      expect(page).to have_css(".banner-component__content-section.govuk-grid-column-two-thirds")
    end
  end

  context "with half column" do
    before do
      render_inline(described_class.new(
        title: "Banner title",
        text: "Some random text",
        media_column_size: :half,
        image: {
          url: "media/images/test/image.png",
          alt: ""
        },
        background_color: "purple",
        link: "http://www.example.com"
      ))
    end

    it "should have container" do
      expect(page).to have_css(".govuk-width-container")
    end

    it "should set content to be one half" do
      expect(page).to have_css(".banner-component__content-section.govuk-grid-column-one-half")
    end
  end

  context "with right align image" do
    before do
      render_inline(described_class.new(
        title: "Banner title",
        text: "Some random text",
        media_side: :right,
        image: {
          url: "media/images/test/image.png",
          alt: ""
        },
        background_color: "purple",
        link: "http://www.example.com"
      ))
    end

    it "should have container" do
      expect(page).to have_css(".govuk-width-container")
    end

    it "should set background colour class" do
      expect(page).to have_css(".purple-bg")
    end
  end
end
