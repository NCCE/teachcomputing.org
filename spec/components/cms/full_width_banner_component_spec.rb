# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cms::FullWidthBannerComponent, type: :component do
  context "standard layout" do
    before do
      render_inline(described_class.new(
        text_content: Cms::Mocks::Text::RichBlocks.as_model,
        image: Cms::Mocks::Images::Image.as_model,
        image_side: "left",
        image_link: "https://www.teachcomputing.test/test-page",
        title: nil,
        background_color: "light-grey"
      ))
    end

    it "renders background color" do
      expect(page).to have_css(".cms-full-width-banner-row.light-grey-bg")
    end

    it "renders the intro text" do
      expect(page).to have_css(".cms-rich-text-block-component")
    end

    it "render box with white background" do
      expect(page).to have_css(".cms-full-width-banner__content.white-bg")
    end

    it "should have image" do
      expect(page).to have_css("img")
    end

    it "render default image fit class" do
      expect(page).to have_css(".cms-full-width-banner__media--cover")
    end

    it "should have link" do
      expect(page).to have_link(href: "https://www.teachcomputing.test/test-page")
    end

    it "has no i belong flag" do
      expect(page).to_not have_css(".cms-full-width-banner__media--with-flag")
    end

    it "has no corner flourish" do
      expect(page).to_not have_css(".cms-full-width-banner__media--with-flourish-left")
      expect(page).to_not have_css(".cms-full-width-banner__media--with-flourish-right")
    end
  end

  context "with heading and right side image" do
    let(:title) { Faker::Lorem.sentence }

    before do
      render_inline(described_class.new(
        text_content: Cms::Mocks::Text::RichBlocks.as_model,
        image: Cms::Mocks::Images::Image.as_model,
        image_side: "right",
        image_link: nil,
        title:
      ))
    end

    it "renders the heading" do
      expect(page).to have_css(".govuk-heading-l.cms-full-width-banner__heading", text: title)
    end

    it "renders the image on the right" do
      expect(page).to have_css(".right-align")
    end
  end

  context "with border" do
    before do
      render_inline(described_class.new(
        text_content: Cms::Mocks::Text::RichBlocks.as_model,
        image: Cms::Mocks::Images::Image.as_model,
        image_side: :left,
        image_link: nil,
        title: nil,
        show_bottom_border: true
      ))
    end

    it "renders the border" do
      expect(page).to have_css(".cms-full-width-banner-row.has-border")
    end
  end

  context "with button" do
    before do
      render_inline(described_class.new(
        text_content: Cms::Mocks::Text::RichBlocks.as_model,
        image: Cms::Mocks::Images::Image.as_model,
        image_side: :left,
        image_link: nil,
        title: nil,
        show_bottom_border: true,
        buttons: [Cms::Mocks::DynamicComponents::Buttons::NcceButton.as_model]
      ))
    end

    it "renders the button" do
      expect(page).to have_css(".govuk-button")
    end
  end

  context "with i belong flag" do
    before do
      render_inline(described_class.new(
        text_content: Cms::Mocks::Text::RichBlocks.as_model,
        image: Cms::Mocks::Images::Image.as_model,
        image_side: "left",
        image_link: nil,
        title: nil,
        show_bottom_border: false,
        i_belong_flag: true
      ))
    end

    it "renders the i belong flag" do
      expect(page).to have_css(".cms-full-width-banner__media--with-flag")
    end
  end

  context "with corner flourish on the left" do
    before do
      render_inline(described_class.new(
        text_content: Cms::Mocks::Text::RichBlocks.as_model,
        image: Cms::Mocks::Images::Image.as_model,
        image_side: "left",
        image_link: nil,
        title: nil,
        show_bottom_border: false,
        i_belong_flag: false,
        corner_flourish: true
      ))
    end

    it "renders the left corner flourish" do
      expect(page).to have_css(".cms-full-width-banner__media--with-flourish-left")
    end
  end

  context "with corner flourish on the right" do
    before do
      render_inline(described_class.new(
        text_content: Cms::Mocks::Text::RichBlocks.as_model,
        image: Cms::Mocks::Images::Image.as_model,
        image_side: "right",
        image_link: nil,
        title: nil,
        show_bottom_border: false,
        i_belong_flag: false,
        corner_flourish: true
      ))
    end

    it "renders the right corner flourish" do
      expect(page).to have_css(".cms-full-width-banner__media--with-flourish-right")
    end
  end

  context "with box color" do
    before do
      render_inline(described_class.new(
        text_content: Cms::Mocks::Text::RichBlocks.as_model,
        image: Cms::Mocks::Images::Image.as_model,
        image_side: "left",
        image_link: nil,
        title: nil,
        show_bottom_border: false,
        i_belong_flag: false,
        box_color: "purple"
      ))
    end

    it "render box with purple background" do
      expect(page).to have_css(".cms-full-width-banner__content.purple-bg")
    end
  end

  context "with image fit" do
    context "contain" do
      before do
        render_inline(described_class.new(
          text_content: Cms::Mocks::Text::RichBlocks.as_model,
          image: Cms::Mocks::Images::Image.as_model,
          image_side: "left",
          image_link: nil,
          title: nil,
          show_bottom_border: false,
          i_belong_flag: false,
          box_color: "purple",
          image_fit: "contain"
        ))
      end

      it "render image fit class" do
        expect(page).to have_css(".cms-full-width-banner__media--contain")
      end
    end
    context "cover" do
      before do
        render_inline(described_class.new(
          text_content: Cms::Mocks::Text::RichBlocks.as_model,
          image: Cms::Mocks::Images::Image.as_model,
          image_side: "left",
          image_link: nil,
          title: nil,
          show_bottom_border: false,
          i_belong_flag: false,
          box_color: "purple",
          image_fit: "cover"
        ))
      end

      it "render image fit class" do
        expect(page).to have_css(".cms-full-width-banner__media--cover")
      end
    end
  end
end
