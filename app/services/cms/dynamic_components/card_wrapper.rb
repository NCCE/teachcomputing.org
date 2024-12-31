module Cms
  module DynamicComponents
    class CardWrapper
      attr_accessor :title, :sub_text, :cards_block, :cards_per_row, :background_color

      def initialize(title:, sub_text:, cards_block:, cards_per_row:, background_color:)
        @title = title
        @sub_text = sub_text
        @cards_block = cards_block
        @cards_per_row = cards_per_row
        @background_color = background_color
      end

      def render
        CmsCardWrapperComponent.new(title:, sub_text:, cards_block:, cards_per_row:, background_color:)
      end
    end
  end
end
