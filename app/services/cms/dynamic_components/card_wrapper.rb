module Cms
  module DynamicComponents
    class CardWrapper
      attr_accessor :title, :sub_text, :cards_block, :cards_per_row, :background_color, :title_as_paragraph

      def initialize(title:, sub_text:, cards_block:, cards_per_row:, background_color:, title_as_paragraph:)
        @title = title
        @sub_text = sub_text
        @cards_block = cards_block
        @cards_per_row = cards_per_row
        @background_color = background_color
        @title_as_paragraph = title_as_paragraph
      end

      def render
        Cms::CardWrapperComponent.new(title:, sub_text:, cards_block:, cards_per_row:, background_color:, title_as_paragraph:)
      end
    end
  end
end
