require "rails_helper"

RSpec.describe BannerComponent, type: :component do
  context "with left align image" do
    before do
      render_inline(described_class.new(
        title: "Banner title",
        text: "Some random text",
        image: {
          url: "media/images/pages/primary-toolkit/introduction_primary_computing.jpeg",
          alt: ""
        },
        background_color: "purple-bg",
        link: "http://www.example.com"
      ))
    end

    it "should have container" do
      expect(page).to have_css(".govuk-width-container")
    end

    it "should set the image class" do
      expect(page).to have_css(".image-left")
    end
  end

  context "with right align image" do
    before do
      render_inline(described_class.new(
        title: "Banner title",
        text: "Some random text",
        image_side: :right,
        image: {
          url: "media/images/pages/primary-toolkit/introduction_primary_computing.jpeg",
          alt: ""
        },
        background_color: "purple-bg",
        link: "http://www.example.com"
      ))
    end

    it "should have container" do
      expect(page).to have_css(".govuk-width-container")
    end

    it "should set background colour class" do
      expect(page).to have_css(".purple-bg")
    end

    it "should set the image class" do
      expect(page).to have_css(".image-right")
    end
  end
end
