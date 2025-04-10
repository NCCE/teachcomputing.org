module Cms
  module Models
    module DynamicComponents
      module Blocks
        class TwoColumnPictureSection
          attr_accessor :text, :image, :background_color, :image_side, :banner, :section_title

          def initialize(text:, image:, image_side:, background_color: nil, banner: nil, section_title: nil)
            @text = text
            @image = image
            @image_side = image_side
            @background_color = background_color
            @banner = banner
            @section_title = section_title
          end

          def render
            Cms::TwoColumnPictureSectionComponent.new(
              text:,
              image:,
              image_side:,
              background_color:,
              banner:,
              section_title:
            )
          end
        end
      end
    end
  end
end
