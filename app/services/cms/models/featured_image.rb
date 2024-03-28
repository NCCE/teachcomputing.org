module Cms
  module Models
    class FeaturedImage
      attr_accessor :image

      def initialize(url, alt, caption, formats, size = :large)
        @image = Image.new(url, alt, caption, formats, size)
      end

      def render
        FeaturedImageComponent.new(@image)
      end
    end
  end
end
