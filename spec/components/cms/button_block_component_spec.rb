# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cms::ButtonBlockComponent, type: :component do

  context "left alignment and no padding and not full width" do
    before do
      render_inline(described_class.new(
        buttons: Array.new(2) { Cms::Mocks::NcceButton.as_model },
        background_color: "purple",
        padding: false,
        alignment: "left",
        full_width: false
      ))
    end

    it "should render buttons" do
      expect(page).to have_css(".govuk-button", count: 2)
    end

    it "should set background color" do
      expect(page).to have_css(".purple-bg")
    end

    it "should be two-thirds column" do
      expect(page).to have_css(".govuk-grid-column-two-thirds")
    end

    it "should set alignment class" do
      expect(page).to have_css(".cms-button-block--left")
    end

    it "should set padding class" do
      expect(page).to have_css("div[class*='govuk-!-padding-0']")
    end

  end

  context "right alignment and no padding and full width" do
    before do
      render_inline(described_class.new(
        buttons: Array.new(2) { Cms::Mocks::NcceButton.as_model },
        background_color: "purple",
        padding: false,
        alignment: "right",
        full_width: true
      ))
    end

    it "should render buttons" do
      expect(page).to have_css(".govuk-button", count: 2)
    end

    it "should set background color" do
      expect(page).to have_css(".purple-bg")
    end

    it "should be two-thirds column" do
      expect(page).to have_css(".govuk-grid-column-full")
    end

    it "should set alignment class" do
      expect(page).to have_css(".cms-button-block--right")
    end
  end

  context "right alignment and padding and full width" do
    before do
      render_inline(described_class.new(
        buttons: Array.new(2) { Cms::Mocks::NcceButton.as_model },
        background_color: "purple",
        padding: true,
        alignment: "center",
        full_width: true
      ))
    end

    it "should render buttons" do
      expect(page).to have_css(".govuk-button", count: 2)
    end

    it "should set background color" do
      expect(page).to have_css(".purple-bg")
    end

    it "should be two-thirds column" do
      expect(page).to have_css(".govuk-grid-column-full")
    end

    it "should set alignment class" do
      expect(page).to have_css(".cms-button-block--center")
    end
  end

end
