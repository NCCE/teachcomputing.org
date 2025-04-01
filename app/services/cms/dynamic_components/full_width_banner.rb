module Cms
  module DynamicComponents
    class FullWidthBanner
      attr_accessor :text_content, :image, :image_side, :buttons, :image_link, :title, :background_color, :box_color, :show_bottom_border, :i_belong_flag, :corner_flourish, :image_fit

      def initialize(text_content:, title:, image: nil, image_side: :left, image_link: nil, background_color: :white, box_color: :white, buttons: [], show_bottom_border: false, i_belong_flag: false, corner_flourish: false, image_fit: "cover")
        @text_content = text_content
        @image = image
        @image_side = image_side
        @image_link = image_link
        @background_color = background_color
        @box_color = box_color
        @title = title
        @buttons = buttons
        @show_bottom_border = show_bottom_border
        @i_belong_flag = i_belong_flag
        @corner_flourish = corner_flourish
        @image_fit = image_fit
      end

      def render
        Cms::FullWidthBannerComponent.new(
          text_content:,
          image:,
          image_side:,
          image_link:,
          background_color:,
          box_color:,
          buttons:,
          title:,
          show_bottom_border:,
          i_belong_flag:,
          corner_flourish:,
          image_fit:
        )
      end
    end
  end
end
