class Cms::ImageComponentPreview < ViewComponent::Preview
  def default
    render Cms::ImageComponent.new(Cms::Mocks::Image.as_model)
  end
end
