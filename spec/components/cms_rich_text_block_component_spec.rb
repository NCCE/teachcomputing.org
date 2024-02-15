require "rails_helper"

RSpec.describe CmsRichTextBlockComponent, type: :component do
  it "renders a paragraph" do
    render_inline(described_class.new({blocks: [
      type: "paragraph",
      children: [
        {type: "text", text: "Hello world!"}
      ]
    ]}))

    expect(page).to have_css("p", text: "Hello world!")
  end

  it "renders a heading" do
    render_inline(described_class.new({blocks: [
      type: "heading",
      level: 1,
      children: [
        {type: "text", text: "Heading world!"}
      ]
    ]}))

    expect(page).to have_css("h1", text: "Heading world!")
  end

  it "renders some text" do
    render_inline(described_class.new({blocks: [
      {type: "text", text: "Just text"}
    ]}))

    expect(page).to have_text("Just text")
  end

  it "renders a link" do
    render_inline(described_class.new({blocks: [
      {
        type: "link",
        url: "https://www.google.com",
        children: [
          {type: "text", text: "A link to google"}
        ]
      }
    ]}))

    expect(page).to have_link("A link to google", href: "https://www.google.com")
  end

  it "renders an ordered list" do
    render_inline(described_class.new({blocks: [
      {
        type: "list",
        format: "ordered",
        children: [
          {type: "list-item", children: [{type: "text", text: "Item 1"}]},
          {type: "list-item", children: [{type: "text", text: "Item 2"}]}
        ]
      }
    ]}))

    expect(page).to have_css("ol", count: 1)
    expect(page).to have_css("ol li", text: "Item 1")
    expect(page).to have_css("ol li", text: "Item 2")
  end

  it "renders an unordered list" do
    render_inline(described_class.new({blocks: [
      {
        type: "list",
        format: "unordered",
        children: [
          {type: "list-item", children: [{type: "text", text: "Item 1"}]},
          {type: "list-item", children: [{type: "text", text: "Item 2"}]}
        ]
      }
    ]}))

    expect(page).to have_css("ul", count: 1)
    expect(page).to have_css("ul li", text: "Item 1")
    expect(page).to have_css("ul li", text: "Item 2")
  end

  it "renders an image" do
    render_inline(described_class.new({blocks: [
      {
        type: "image",
        image: {url: "/an-image.png"}
      }
    ]}))

    expect(page).to have_css("img[src='/an-image.png']")
  end
end
