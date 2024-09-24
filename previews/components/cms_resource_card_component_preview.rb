class CmsResourceCardComponentPreview < ViewComponent::Preview
  layout "full-width"

  def default
    render(CmsResourceCardComponent.new(
      title: "Page title",
      body_text: Cms::Mocks::RichBlocks.generate,
      icon: Cms::Mocks::Image.as_model,
      colour_theme: "standard",
      button_text: Faker::Lorem.word,
      button_link: Faker::Internet.url
    ))
  end
end
