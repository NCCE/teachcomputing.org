module Cms
  module DynamicComponents
    class CardWrapper
      attr_accessor :title, :cards_block, :cards_per_row, :background_color, :title_as_paragraph

      def initialize(title:, cards_block:, cards_per_row:, background_color:, title_as_paragraph:)
        @title = title
        @cards_block = cards_block
        @cards_per_row = cards_per_row
        @background_color = background_color
        @title_as_paragraph = title_as_paragraph
      end

      def render
        Cms::CardWrapperComponent.new(title:, cards_block:, cards_per_row:, background_color:, title_as_paragraph:)
      end
    end
  end
end
