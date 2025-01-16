# frozen_string_literal: true

class Cms::ImageComponent < ViewComponent::Base
  delegate :cms_image, to: :helpers

  def initialize(image, show_caption: true, link: nil)
    @image = image
    @show_caption = show_caption
    @link = link
  end
end
