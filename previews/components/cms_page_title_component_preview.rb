class CmsPageTitleComponentPreview < ViewComponent::Preview
  layout "full-width"

  def default
    render(CmsPageTitleComponent.new(title: "Page title", intro_text: nil))
  end

  def with_intro_text
    render(CmsPageTitleComponent.new(title: "Page title", intro_text: "Welcome to the page"))
  end
end
