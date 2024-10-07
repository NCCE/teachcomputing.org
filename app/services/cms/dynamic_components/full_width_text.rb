module Cms
  module DynamicComponents
    class FullWidthText
      attr_accessor :blocks, :background_color

      def initialize(blocks:, background_color:)
        @blocks = blocks
        @background_color = background_color
      end

      def render
        CmsFullWidthTextBlockComponent.new(blocks:, background_color:)
      end
    end
  end
end
