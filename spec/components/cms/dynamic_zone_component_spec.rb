# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cms::DynamicZoneComponent, type: :component do
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
    expect(page).to have_css(".cms-dynamic-zone")
  end

  it "should render content blocks" do
    expect(page).to have_css(".cms-rich-text-block-component", count: 2)
  end
end
