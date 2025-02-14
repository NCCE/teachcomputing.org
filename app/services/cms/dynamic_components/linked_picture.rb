module Cms
  module DynamicComponents
    class LinkedPicture
      attr_accessor :image, :link

      def initialize(image:, link:)
        @image = image
        @link = link
      end

      def render
        Cms::ImageComponent.new(image, show_caption: false, link:)
      end
    end
  end
end
