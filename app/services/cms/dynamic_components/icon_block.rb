module Cms
  module DynamicComponents
    class IconBlock
      attr_accessor :icons

      def initialize(icons:)
        @icons = icons
      end

      def render
        Cms::IconBlockComponent.new(icons:)
      end
    end

    class Icon
      attr_accessor :text, :image

      def initialize(text:, image:)
        @text = text
        @image = image
      end
    end
  end
end
