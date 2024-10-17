class CmsIconBlockComponentPreview < ViewComponent::Preview
  def default
    render(CmsIconBlockComponent.new(icons: Cms::Mocks::IconBlocks.as_model(icon_count: 3).icons))
  end
end
