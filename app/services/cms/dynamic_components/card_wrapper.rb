module Cms
  module DynamicComponents
    class CardWrapper
      attr_accessor :title, :cards_block, :cards_per_row, :background_color

      def initialize(title:, cards_block:, cards_per_row:, background_color:)
        @title = title
        @cards_block = cards_block
        @cards_per_row = cards_per_row
        @background_color = background_color
      end

      def render
        CmsCardWrapperComponent.new(title:, cards_block:, cards_per_row:, background_color:)
      end
    end
  end
end
