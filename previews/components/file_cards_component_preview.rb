class FileCardsComponentPreview < ViewComponent::Preview
  def default
    cards = [
      {
        name: "A card",
        file: "https://www.example.com/",
        type: "JPG",
        size: "1 Megabyte",
        created: "14 Oct 2021"
      },
      {
        name: "Another card",
        file: "https://www.example.com/",
        type: "PDF",
        size: "150 Kilobytes",
        created: "12 Oct 2021"
      }
    ]
    render(FileCardsComponent.new(cards: cards))
  end
end
