# frozen_string_literal: true

class FeaturedImageComponent < ViewComponent::Base
  delegate :cms_image, to: :helpers

  def initialize(resource, image)
    @resource = resource
    @image = image
    @alt_text = image[:attributes][:alternativeText]
    @caption = image[:attributes][:caption]
  end
end
