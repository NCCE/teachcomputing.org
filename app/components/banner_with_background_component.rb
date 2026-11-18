# frozen_string_literal: true

# Component adds a full width background image with an optional label
# The background_image_css should be a simple css class containing the background image that is required
class BannerWithBackgroundComponent < ViewComponent::Base
  def initialize(background_image_css:, label: nil)
    @background_image_css = background_image_css
    @label = label
  end
end
