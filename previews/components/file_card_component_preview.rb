class FileCardComponentPreview < ViewComponent::Preview
  def default
    title = "Example file 1"
    file_card = {
      file: "https://www.example.com/",
      type: "JPG",
      size: "1 Megabyte",
      created: "14 Oct 2021"
    }
    render(FileCardComponent.new(file_card: file_card, title: title))
  end
end
