class Cms::ProgrammePictureCardComponentPreview < ViewComponent::Preview
  def default
    render(Cms::ProgrammePictureCardComponent.new(
      title: "Programme card title",
      text_content: Cms::Mocks::RichBlocks.as_model,
      image: Cms::Mocks::Image.as_model,
      card_links: Cms::Mocks::DynamicComponents::MultiStateLink.as_model,
      programme: Programme.i_belong
    ))
  end
end
