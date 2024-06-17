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
        link: {
          url: "https://www.example.com",
          text: "Test link",
          class: "govuk-button"
        },
        button: {
          text: "Button text",
          link: "https://www.example.com",
          class: "govuk-button"
        }
      ))
    end

    it "should render the text" do
      expect(page).to have_css(".govuk-body", text: "Some random text")
    end

    it "should render title" do
      expect(page).to have_css(".govuk-heading-m", text: "Banner title")
    end

    it "should render link" do
      expect(page).to have_link("Test link", href: "https://www.example.com")
    end

    it "should have container" do
      expect(page).to have_css(".govuk-width-container")
    end

    it "should default to two thirds for content" do
      expect(page).to have_css(".banner-component__content-section--two-thirds")
    end

    it "should have a button" do
      expect(page).to have_link("Button text", href: "https://www.example.com", class: "govuk-button")
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
        link: {
          url: "https://www.example.com",
          text: "Test link"
        }
      ))
    end

    it "should have container" do
      expect(page).to have_css(".govuk-width-container")
    end

    it "should set side class on banner-component" do
      expect(page).to have_css(".banner-component--media-left")
    end

    it "should set content to be one half" do
      expect(page).to have_css(".banner-component__media-section--half")
      expect(page).to have_css(".banner-component__content-section--half")
    end

    it "should not have a button" do
      expect(page).not_to have_css(".govuk-button")
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
        link: {
          url: "https://www.example.com",
          text: "Test link",
          class: "govuk-button"
        }
      ))
    end

    it "should have container" do
      expect(page).to have_css(".govuk-width-container")
    end

    it "should set side class on banner-component" do
      expect(page).to have_css(".banner-component--media-right")
    end

    it "should set background colour class" do
      expect(page).to have_css(".purple-bg")
    end
  end

  context "with link in the header" do
    before do
      render_inline(described_class.new(
        title: "Banner title",
        title_link: "https://www.google.com",
        text: "Some random text",
        media_column_size: :half,
        image: {
          url: "media/images/test/image.png",
          alt: ""
        },
        background_color: "purple",
        link: {
          url: "https://www.example.com",
          text: "Test link"
        }
      ))
    end

    it "has a title link" do
      expect(page).to have_link("Banner title", href: "https://www.google.com")
    end
  end
end
