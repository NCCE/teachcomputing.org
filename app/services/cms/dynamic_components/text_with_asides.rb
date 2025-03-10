module Cms
  module DynamicComponents
    class TextWithAsides
      attr_accessor :blocks, :asides, :background_color

      def initialize(blocks:, asides:, background_color:)
        @blocks = blocks
        @asides = asides
        @background_color = background_color
      end

      def render
        Cms::TextWithAsidesComponent.new(blocks:, asides:, background_color:)
      end
    end
  end
end
