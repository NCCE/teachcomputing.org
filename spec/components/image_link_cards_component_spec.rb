require "rails_helper"

RSpec.describe ImageLinkCardsComponent, type: :component do
  let(:cards) do
    [{
      title_locale: "test.image_link_card.title",
      link_url: "https://www.example.com",
      image_path: "media/images/test/example.svg",
      img_alt_locale: "test.image_link_card.img_alt",
      text_locale: "test.image_link_card.text_html"
    },
      {
        title_locale: "test.image_link_card.title",
        link_url: "https://www.example.com",
        image_path: "media/images/test/example.svg",
        img_alt_locale: "test.image_link_card.img_alt",
        text_locale: "test.image_link_card.text_html"
      }]
  end

  it "renders a card element for each card" do
    render_inline(described_class.new(cards: cards))
    expect(page).to have_css(".image-link-card-component", count: 2)
  end
end
