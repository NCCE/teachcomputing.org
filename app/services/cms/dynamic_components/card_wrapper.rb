module Cms
  module DynamicComponents
    class CardWrapper
      attr_accessor :title, :cards_block, :cards_per_row, :background_colour

      def initialize(title:, cards_block:, cards_per_row:, background_colour:)
        @title = title
        @cards_block = cards_block
        @cards_per_row = cards_per_row
        @background_colour = background_colour
      end

      def render
        CmsCardWrapperComponent.new(title:, cards_block:, cards_per_row:, background_colour:)
      end
    end
  end
end
