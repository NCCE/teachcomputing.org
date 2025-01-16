module Cms
  module DynamicComponents
    class FullWidthText
      attr_accessor :blocks, :background_color, :show_bottom_border

      def initialize(blocks:, background_color:, show_bottom_border:)
        @blocks = blocks
        @background_color = background_color
        @show_bottom_border = show_bottom_border
      end

      def render
        Cms::FullWidthTextBlockComponent.new(blocks:, background_color:, show_bottom_border:)
      end
    end
  end
end
