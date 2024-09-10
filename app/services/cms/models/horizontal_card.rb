module Cms
  module Models
    class HorizontalCard
      attr_accessor :title, :body_blocks, :image, :image_link, :ribbon_colour

      def initialize(title:, body_blocks:, image:, image_link:, ribbon_colour:)
        @title = title
        @body_blocks = body_blocks
        @image = image
        @image_link = image_link
        @ribbon_colour = ribbon_colour
      end

      def render
        CmsHorizontalCardComponent.new(title:, body_blocks:, image:, image_link:, ribbon_colour:)
      end
    end
  end
end
