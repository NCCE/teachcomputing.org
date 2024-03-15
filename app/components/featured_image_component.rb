# frozen_string_literal: true

class FeaturedImageComponent < ViewComponent::Base
  delegate :cms_image, to: :helpers

  def initialize(image)
    @image = image
  end
end
