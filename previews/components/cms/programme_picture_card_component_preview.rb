class Cms::ProgrammePictureCardComponentPreview < ViewComponent::Preview
  def default
    render(Cms::ProgrammePictureCardComponent.new(
      title: "Programme card title",
      text_content: Cms::Mocks::Text::RichBlocks.as_model,
      image: Cms::Mocks::Images::Image.as_model,
      card_links: Cms::Mocks::Meta::MultiStateLink.as_model,
      programme: Programme.i_belong
    ))
  end
end
