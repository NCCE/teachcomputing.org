module Cms
  module DynamicComponents
    class LinkedPicture
      attr_accessor :image, :link

      def initialize(image:, link:)
        @image = image
        @link = link
      end

      def render
        CmsImageComponent.new(image, show_caption: false, link:)
      end
    end
  end
end