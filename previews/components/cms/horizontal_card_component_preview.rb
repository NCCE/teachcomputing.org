class Cms::HorizontalCardComponentPreview < ViewComponent::Preview
  layout "full-width"

  def default
    render(Cms::HorizontalCardComponent.new(
      title: "Page title",
      body_blocks: Cms::Mocks::RichBlocks.generate,
      image: nil,
      image_link: nil,
      color_theme: nil,
      icon_block: nil
    ))
  end

  def with_image_and_image_link
    render(Cms::HorizontalCardComponent.new(
      title: "Page title",
      body_blocks: Cms::Mocks::RichBlocks.generate,
      image: Cms::Mocks::Image.as_model,
      image_link: Faker::Internet.url,
      color_theme: nil,
      icon_block: nil
    ))
  end

  def with_color_theme
    render(Cms::HorizontalCardComponent.new(
      title: "Page title",
      body_blocks: Cms::Mocks::RichBlocks.generate,
      image: nil,
      image_link: nil,
      color_theme: "standard",
      icon_block: nil
    ))
  end

  def with_icon_block
    render(Cms::HorizontalCardComponent.new(
      title: "Page title",
      body_blocks: Cms::Mocks::RichBlocks.generate,
      image: nil,
      image_link: nil,
      color_theme: "standard",
      icon_block: Cms::Mocks::IconBlocks.as_model(icon_count: 3)
    ))
  end
end
