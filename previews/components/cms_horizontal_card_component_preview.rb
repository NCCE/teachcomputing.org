class CmsHorizontalCardComponentPreview < ViewComponent::Preview
  layout "full-width"

  def default
    render(CmsHorizontalCardComponent.new(
      title: "Page title",
      body_blocks: Cms::Mocks::RichBlocks.generate,
      image: nil,
      image_link: nil,
      colour_theme: nil,
      icon_block: nil
    ))
  end

  def with_image_and_image_link
    render(CmsHorizontalCardComponent.new(
      title: "Page title",
      body_blocks: Cms::Mocks::RichBlocks.generate,
      image: Cms::Mocks::Image.as_model,
      image_link: Faker::Internet.url,
      colour_theme: nil,
      icon_block: nil
    ))
  end

  def with_colour_theme
    render(CmsHorizontalCardComponent.new(
      title: "Page title",
      body_blocks: Cms::Mocks::RichBlocks.generate,
      image: nil,
      image_link: nil,
      colour_theme: "standard",
      icon_block: nil
    ))
  end

  def with_icon_block
    render(CmsHorizontalCardComponent.new(
      title: "Page title",
      body_blocks: Cms::Mocks::RichBlocks.generate,
      image: nil,
      image_link: nil,
      colour_theme: "standard",
      icon_block: Cms::Mocks::IconBlocks.as_model(icon_count: 3)
    ))
  end
end
