require "rails_helper"

RSpec.describe FileCardsComponent, type: :component do
  let(:cards) do
    [
      {
        file: "https://www.example.com/",
        type: "JPG",
        size: "1 Megabyte",
        created: "14 Oct 2021"
      },
      {
        file: "https://www.example.com/",
        type: "PDF",
        size: "150 Kilobytes",
        created: "12 Oct 2021"
      }
    ]
  end

  before do
    render_inline(described_class.new(cards: cards))
  end

  it "renders a wrapper element" do
    expect(page).to have_css(".file-cards-component", count: 1)
  end

  it "renders an element for each card" do
    expect(page).to have_css(".file-card-component", count: 2)
  end
end
