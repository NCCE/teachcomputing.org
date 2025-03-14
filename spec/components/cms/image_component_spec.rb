# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cms::ImageComponent, type: :component do
  let(:caption) { "This is a picture" }

  context "with link" do
    before do
      render_inline(described_class.new(
        Cms::Mocks::Image.as_model,
        link: "https://www.google.com"
      ))
    end

    it "should show image" do
      expect(page).to have_css("img")
    end

    it "should set default class" do
      expect(page).to have_css(".cms-image")
    end

    it "should have link" do
      expect(page).to have_link(href: "https://www.google.com")
    end
  end

  context "without caption" do
    before do
      render_inline(described_class.new(
        Cms::Mocks::Image.as_model,
        show_caption: false
      ))
    end

    it "should show image" do
      expect(page).to have_css("img")
    end
  end

  context "with caption" do
    before do
      render_inline(described_class.new(
        Cms::Mocks::Image.as_model(caption:),
        show_caption: true
      ))
    end

    it "should show image" do
      expect(page).to have_css("img")
    end

    it "should show caption" do
      expect(page).to have_text(caption)
    end
  end

  context "with caption but show_caption is false" do
    before do
      render_inline(described_class.new(
        Cms::Mocks::Image.as_model(caption:),
        show_caption: false
      ))
    end

    it "should show image" do
      expect(page).to have_css("img")
    end

    it "should not show caption" do
      expect(page).not_to have_text(caption)
    end
  end

  context "with additional classes" do

    context "as string" do
      before do
        render_inline(described_class.new(
          Cms::Mocks::Image.as_model(caption:),
          classes: "another-class"
        ))
      end

      it "should add them" do
        expect(page).to have_css(".cms-image.another-class")
      end
    end

    context "as array" do
      before do
        render_inline(described_class.new(
          Cms::Mocks::Image.as_model(caption:),
          classes: ["another-class", "second-class"]
        ))
      end

      it "should add them" do
        expect(page).to have_css(".cms-image.another-class.second-class")
      end
    end

  end
end
