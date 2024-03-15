module Cms
  module Models
    class FeaturedImage
      attr_accessor :url, :alt, :caption, :formats

      def initialize(url, alt, caption, formats)
        @url = url
        @alt = alt
        @caption = caption
        @formats = formats
      end

      def render
        FeaturedImageComponent.new(self)
      end
    end
  end
end
