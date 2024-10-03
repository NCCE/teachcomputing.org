class CmsPictureCardComponentPreview < ViewComponent::Preview
  layout "full-width"

  def default
    render(CmsPictureCardComponent.new(
      title: Faker::Lorem.word,
      body_text: Cms::Mocks::RichBlocks.as_model,
      image: Cms::Mocks::Image.as_model,
      colour_theme: "standard",
      link: Faker::Internet.url
    ))
  end
end
