module Cms
  module DynamicComponents
    class TwoColumnPictureSection
      attr_accessor :text, :image, :background_color, :image_side

      def initialize(text:, image:, image_side:, background_color: nil)
        @text = text
        @image = image
        @image_side = image_side
        @background_color = background_color
      end

      def render
        Cms::TwoColumnPictureSectionComponent.new(
          text:,
          image:,
          image_side:,
          background_color:
        )
      end
    end
  end
end
