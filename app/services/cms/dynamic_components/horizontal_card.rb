module Cms
  module DynamicComponents
    class HorizontalCard
      attr_accessor :title, :body_blocks, :image, :image_link, :ribbon_colour, :icon_block

      def initialize(title:, body_blocks:, image:, image_link:, ribbon_colour:, icon_block:)
        @title = title
        @body_blocks = body_blocks
        @image = image
        @image_link = image_link
        @ribbon_colour = ribbon_colour
        @icon_block = icon_block
      end

      def render
        CmsHorizontalCardComponent.new(title:, body_blocks:, image:, image_link:, ribbon_colour:, icon_block:)
      end
    end
  end
end
