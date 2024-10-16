module Cms
  module DynamicComponents
    class FullWidthText
      attr_accessor :blocks, :background_color, :show_border_bottom

      def initialize(blocks:, background_color:, show_border_bottom:)
        @blocks = blocks
        @background_color = background_color
        @show_border_bottom = show_border_bottom
      end

      def render
        CmsFullWidthTextBlockComponent.new(blocks:, background_color:, show_border_bottom:)
      end
    end
  end
end
