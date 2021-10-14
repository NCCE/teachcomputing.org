class FileCardsComponentPreview < ViewComponent::Preview
  def default
    cards = [
      {
        title: 'Example file 1',
        file_info: {
          path: 'https://www.example.com/',
          type: 'JPG',
          size: '1 Megabyte',
          updated: '14 Oct 2021'
        }
      },
      {
        title: 'Example file 2',
        file_info: {
          path: 'https://www.example.com/',
          type: 'PDF',
          size: '150 Kilobytes',
          updated: '12 Oct 2021'
        }
      }
    ]
    render(FileCardsComponent.new(cards: cards))
  end
end
