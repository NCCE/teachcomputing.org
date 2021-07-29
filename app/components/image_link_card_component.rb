# frozen_string_literal: true

class ImageLinkCardComponent < ViewComponent::Base
  # def initialize(heading_link_text:, link_url:, image_path:, test:)
  def initialize(image_link_card:)
    @title_locale = image_link_card[:title_locale]
    @link_url = image_link_card[:link_url]
    @image_path = image_link_card[:image_path]
    @image_alt_locale = image_link_card[:image_alt_locale]
    @text_locale = image_link_card[:text_locale]
  end
end
