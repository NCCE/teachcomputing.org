# frozen_string_literal: true

class CmsImageComponent < ViewComponent::Base
  delegate :cms_image, to: :helpers

  def initialize(image, size: :medium)
    @image = image
    @size = size
  end

  def call
    cms_image(@image, @size)
  end
end
