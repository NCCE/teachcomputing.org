module Cms
  module DynamicComponents
    class FullWidthBanner
      attr_accessor :text_content, :image, :image_side, :buttons, :image_link, :title, :background_color, :show_bottom_border

      def initialize(text_content:, title:, image: nil, image_side: :left, image_link: nil, background_color: :white, buttons: [], show_bottom_border: false)
        @text_content = text_content
        @image = image
        @image_side = image_side
        @image_link = image_link
        @background_color = background_color
        @title = title
        @buttons = buttons
        @show_bottom_border = show_bottom_border
      end

      def render
        CmsFullWidthBannerComponent.new(
          text_content:,
          image:,
          image_side:,
          image_link:,
          background_color:,
          buttons:,
          title:,
          show_bottom_border:
        )
      end
    end
  end
end