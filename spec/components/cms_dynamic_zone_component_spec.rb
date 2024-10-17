# frozen_string_literal: true

require "rails_helper"

RSpec.describe CmsDynamicZoneComponent, type: :component do
  context "with spacing" do
    before do
      render_inline(described_class.new(
        cms_models: [
          Cms::Models::TextBlock.new(blocks: [
            type: "paragraph",
            children: [
              {type: "text", text: "Hello world!"}
            ]
          ]),
          Cms::Models::TextBlock.new(blocks: [
            type: "paragraph",
            children: [
              {type: "text", text: "Hello world! Number 2"}
            ]
          ])
        ]
      ))
    end

    it "should render wrapper" do
      expect(page).to have_css(".cms-dynamic-zone.govuk-\\!-margin-bottom-7.govuk-\\!-margin-top-7")
    end

    it "should render content blocks" do
      expect(page).to have_css(".cms-rich-text-block-component", count: 2)
    end
  end

  context "without spacing" do
    before do
      render_inline(described_class.new(
        cms_models: [
          Cms::Models::TextBlock.new(blocks: [
            type: "paragraph",
            children: [
              {type: "text", text: "Hello world!"}
            ]
          ]),
          Cms::Models::TextBlock.new(blocks: [
            type: "paragraph",
            children: [
              {type: "text", text: "Hello world! Number 2"}
            ]
          ])
        ],
        with_spacing: false
      ))
    end

    it "should render wrapper" do
      expect(page).to have_css(".cms-dynamic-zone")
    end

    it "should render wrapper without spacing" do
      expect(page).to_not have_css(".cms-dynamic-zone.govuk-\\!-margin-bottom-7")
    end

    it "should render content blocks" do
      expect(page).to have_css(".cms-rich-text-block-component", count: 2)
    end
  end
end
