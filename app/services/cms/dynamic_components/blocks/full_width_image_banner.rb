module Cms
  module DynamicComponents
    module Blocks
      class FullWidthImageBanner
        attr_accessor :background_image, :overlay_title, :overlay_text, :overlay_icon, :overlay_side

        def initialize(background_image:, overlay_title:, overlay_text:, overlay_icon:, overlay_side:)
          @background_image = background_image
          @overlay_title = overlay_title
          @overlay_text = overlay_text
          @overlay_icon = overlay_icon
          @overlay_side = overlay_side
        end

        def render
          Cms::FullWidthImageBannerComponent.new(background_image:, overlay_title:, overlay_text:, overlay_icon:, overlay_side:)
        end
      end
    end
  end
end
