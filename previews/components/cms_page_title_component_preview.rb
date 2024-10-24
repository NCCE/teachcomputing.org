class CmsPageTitleComponentPreview < ViewComponent::Preview
  layout "full-width"

  def default
    render(CmsPageTitleComponent.new(title: "Page title", sub_text: nil))
  end

  def with_sub_text
    render(CmsPageTitleComponent.new(title: "Page title", sub_text: "Welcome to the page"))
  end
end
