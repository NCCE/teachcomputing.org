class Cms::PageTitleComponentPreview < ViewComponent::Preview
  layout "full-width"

  def default
    render(Cms::PageTitleComponent.new(title: "Page title", sub_text: nil))
  end

  def with_sub_text
    render(Cms::PageTitleComponent.new(title: "Page title", sub_text: "Welcome to the page"))
  end
end
