require "rails_helper"

RSpec.describe CmsRichTextBlockTextComponent, type: :component do
  it "renders a paragraph" do
    render_inline(described_class.new(blocks: [
      type: "paragraph",
      children: [
        {type: "text", text: "Hello world!"}
      ]
    ]))

    expect(page).to have_text("Hello world!")
  end

  it "renders a large heading" do
    render_inline(described_class.new(blocks: [
      type: "heading",
      level: 1,
      children: [
        {type: "text", text: "Heading world!"}
      ]
    ]))

    expect(page).to have_text("Heading world!")
  end

  it "renders some text" do
    render_inline(described_class.new(blocks: [
      {type: "text", text: "Just text"}
    ]))

    expect(page).to have_text("Just text")
  end

  it "renders a link" do
    render_inline(described_class.new(blocks: [
      {
        type: "link",
        url: "https://www.google.com",
        children: [
          {type: "text", text: "A link to google"}
        ]
      }
    ]))

    expect(page).to have_text("A link to google (https://www.google.com)")
  end

  it "renders an ordered list" do
    render_inline(described_class.new(blocks: [
      {
        type: "list",
        format: "ordered",
        children: [
          {type: "list-item", children: [{type: "text", text: "Item 1"}]},
          {type: "list-item", children: [{type: "text", text: "Item 2"}]}
        ]
      }
    ]))

    expect(page).to have_text("1. Item 1")
    expect(page).to have_text("2. Item 2")
  end

  it "renders an unordered list" do
    render_inline(described_class.new(blocks: [
      {
        type: "list",
        format: "unordered",
        children: [
          {type: "list-item", children: [{type: "text", text: "Item 1"}]},
          {type: "list-item", children: [{type: "text", text: "Item 2"}]}
        ]
      }
    ]))

    expect(page).to have_text("* Item 1")
    expect(page).to have_text("* Item 2")
  end

  it "renders a quote" do
    render_inline(described_class.new(blocks: [
      {
        type: "quote",
        children: [
          {type: "text", text: "Quoted"}
        ]
      }
    ]))

    expect(page).to have_text("Quoted")
  end
end
