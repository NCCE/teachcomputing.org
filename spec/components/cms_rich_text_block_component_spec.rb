require "rails_helper"

RSpec.describe CmsRichTextBlockComponent, type: :component do
  let(:component) {
    double("component")
  }

  it "renders a paragraph" do
    render_inline(described_class.new(component, blocks: [
      type: "paragraph",
      children: [
        {type: "text", text: "Hello world!"}
      ]
    ]))

    expect(page).to have_css("p", text: "Hello world!")
  end

  it "renders a large heading" do
    render_inline(described_class.new(component, blocks: [
      type: "heading",
      level: 1,
      children: [
        {type: "text", text: "Heading world!"}
      ]
    ]))

    expect(page).to have_css(".govuk-heading-l", text: "Heading world!")
  end

  it "renders a medium heading" do
    render_inline(described_class.new(component, blocks: [
      type: "heading",
      level: 2,
      children: [
        {type: "text", text: "Heading world!"}
      ]
    ]))

    expect(page).to have_css(".govuk-heading-m", text: "Heading world!")
  end

  it "renders a small heading" do
    render_inline(described_class.new(component, blocks: [
      type: "heading",
      level: 3,
      children: [
        {type: "text", text: "Heading world!"}
      ]
    ]))

    expect(page).to have_css(".govuk-heading-s", text: "Heading world!")
  end

  it "renders some text" do
    render_inline(described_class.new(component, blocks: [
      {type: "text", text: "Just text"}
    ]))

    expect(page).to have_text("Just text")
  end

  it "renders bold text" do
    render_inline(described_class.new(component, blocks: [
      {type: "text", text: "Bold text", bold: true}
    ]))

    expect(page).to have_css(".cms-rich-text-block-component__text--bold", text: "Bold text")
  end

  it "renders italic text" do
    render_inline(described_class.new(component, blocks: [
      {type: "text", text: "Italic text", italic: true}
    ]))

    expect(page).to have_css(".cms-rich-text-block-component__text--italic", text: "Italic text")
  end

  it "renders underlined text" do
    render_inline(described_class.new(component, blocks: [
      {type: "text", text: "Underlined text", underline: true}
    ]))

    expect(page).to have_css(".cms-rich-text-block-component__text--underline", text: "Underlined text")
  end

  it "renders strikethrough text" do
    render_inline(described_class.new(component, blocks: [
      {type: "text", text: "Strikethrough text", strikethrough: true}
    ]))

    expect(page).to have_css(".cms-rich-text-block-component__text--strikethrough", text: "Strikethrough text")
  end

  it "renders code text" do
    render_inline(described_class.new(component, blocks: [
      {type: "text", text: "Code text", code: true}
    ]))

    expect(page).to have_css(".cms-rich-text-block-component__text--code", text: "Code text")
  end

  it "renders a link" do
    render_inline(described_class.new(component, blocks: [
      {
        type: "link",
        url: "https://www.google.com",
        children: [
          {type: "text", text: "A link to google"}
        ]
      }
    ]))

    expect(page).to have_link("A link to google", href: "https://www.google.com")
  end

  it "renders an ordered list" do
    render_inline(described_class.new(component, blocks: [
      {
        type: "list",
        format: "ordered",
        children: [
          {type: "list-item", children: [{type: "text", text: "Item 1"}]},
          {type: "list-item", children: [{type: "text", text: "Item 2"}]}
        ]
      }
    ]))

    expect(page).to have_css("ol", count: 1)
    expect(page).to have_css("ol li", text: "Item 1")
    expect(page).to have_css("ol li", text: "Item 2")
  end

  it "renders an unordered list" do
    render_inline(described_class.new(component, blocks: [
      {
        type: "list",
        format: "unordered",
        children: [
          {type: "list-item", children: [{type: "text", text: "Item 1"}]},
          {type: "list-item", children: [{type: "text", text: "Item 2"}]}
        ]
      }
    ]))

    expect(page).to have_css("ul", count: 1)
    expect(page).to have_css("ul li", text: "Item 1")
    expect(page).to have_css("ul li", text: "Item 2")
  end

  it "renders an image" do
    render_inline(described_class.new(component, blocks: [
      {
        type: "image",
        image: {url: "/an-image.png"}
      }
    ]))

    expect(page).to have_css("img[src='/an-image.png']")
  end

  it "renders a quote" do
    render_inline(described_class.new(component, blocks: [
      {
        type: "quote",
        children: [
          {type: "text", text: "Quoted"}
        ]
      }
    ]))

    expect(page).to have_css("blockquote", text: "Quoted")
  end
end
