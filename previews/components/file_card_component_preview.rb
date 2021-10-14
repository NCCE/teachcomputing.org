class FileCardComponentPreview < ViewComponent::Preview
  def default
    card = {
      title: 'Example file 1',
      file_info: {
        path: 'https://www.example.com/',
        type: 'JPG',
        size: '1 Megabyte',
        updated: '14 Oct 2021'
      }
    }
    render(FileCardComponent.new(file_card: card))
  end
end
