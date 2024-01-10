require "rails_helper"

RSpec.describe ImageLinkCardComponent, type: :component do
  let(:image_link_card) do
    {
      title_locale: "test.image_link_card.title",
      link_url: "https://www.example.com",
      image_path: "media/images/test/example.svg",
      img_alt_locale: "test.image_link_card.img_alt",
      text_locale: "test.image_link_card.text_html"
    }
  end

  it "renders title from locale passed in" do
    render_inline(described_class.new(image_link_card:))
    expect(page).to have_text("Test card title")
  end

  it "renders text from locale passed in" do
    render_inline(described_class.new(image_link_card:))
    expect(page).to have_text("Lorem ipsum dolor sit amet")
  end

  it "includes image alt from locale passed in" do
    render_inline(described_class.new(image_link_card:))
    expect(page).to have_xpath('//img[contains(@class, "image-link-card-component__image")][contains(@alt, "Test image alt text")]')
  end

  it "includes link to correct url" do
    render_inline(described_class.new(image_link_card:))
    expect(page).to have_link("Test card title", href: "https://www.example.com")
  end
end
