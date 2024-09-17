module Cms
  module DynamicComponents
    class FullWidthBanner
      attr_accessor :text_content, :image, :image_side, :buttons, :image_link, :background_color

      def initialize(text_content:, image: nil, image_side: :left, image_link: nil, background_color: :white, buttons: [])
        @text_content = text_content
        @image = image
        @image_side = image_side
        @image_link = image_link
        @background_color = background_color
        @buttons = buttons
      end

      def render
        CmsFullWidthBannerComponent.new(
          text_content:,
          image:,
          image_side:,
          image_link:,
          background_color:,
          buttons:
        )
      end
    end
  end
end
