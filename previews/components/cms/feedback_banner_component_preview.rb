# frozen_string_literal: true

class Cms::FeedbackBannerComponentPreview < ViewComponent::Preview
  def default
    render(Cms::FeedbackBannerComponent.new(
      title: "title",
      button: Cms::Mocks::DynamicComponents::Buttons::NcceButton.as_model
    ))
  end
end
