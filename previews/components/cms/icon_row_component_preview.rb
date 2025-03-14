class Cms::IconRowComponentPreview < ViewComponent::Preview
  def default
    render(Cms::IconRowComponent.new(icons: Array.new(5) { Cms::Mocks::Icon.as_model }, background_color: nil))
  end

  def dark_background
    render(Cms::IconRowComponent.new(icons: Array.new(5) { Cms::Mocks::Icon.as_model }, background_color: "purple"))
  end
end
