module Cms
  module Models
    class Image
      attr_accessor :default_size, :url, :alt, :caption, :formats

      def initialize(url, alt, caption, formats, default_size)
        @default_size = default_size
        @url = url
        @alt = alt
        @caption = caption
        @formats = formats
        @default_size = default_size
      end

      def image_url
        if @formats&.has_key? @default_size.to_sym
          @formats[@default_size.to_sym][:url]
        else
          @url
        end
      end

      def render
        CmsImageComponent.new(self, size: @default_size)
      end
    end
  end
end
