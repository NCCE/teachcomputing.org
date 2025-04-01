class Cms::ImageComponentPreview < ViewComponent::Preview
  def default
    render Cms::ImageComponent.new(Cms::Mocks::ImageComponents::Image.as_model)
  end
end
