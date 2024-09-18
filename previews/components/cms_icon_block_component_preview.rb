class CmsIconBlockComponentPreview < ViewComponent::Preview
  def default
    render(CmsIconBlockComponent.new(icons: Cms::Mocks::IconBlocks.generate(3).icons))
  end
end
