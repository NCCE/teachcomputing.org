class Cms::IconBlockComponentPreview < ViewComponent::Preview
  def default
    render(Cms::IconBlockComponent.new(icons: Cms::Mocks::DynamicComponents::ContentBlocks::IconBlocks.as_model(icon_count: 3).icons))
  end
end
