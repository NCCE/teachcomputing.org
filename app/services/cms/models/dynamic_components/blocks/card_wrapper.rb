module Cms
  module Models
    module DynamicComponents
      module Blocks
        class CardWrapper
          attr_accessor :title, :intro_text, :cards_block, :cards_per_row, :background_color, :title_as_paragraph

          def initialize(title:, intro_text:, cards_block:, cards_per_row:, background_color:, title_as_paragraph:)
            @title = title
            @intro_text = intro_text
            @cards_block = cards_block
            @cards_per_row = cards_per_row
            @background_color = background_color
            @title_as_paragraph = title_as_paragraph
          end

          def render
            Cms::CardWrapperComponent.new(title:, intro_text:, cards_block:, cards_per_row:, background_color:, title_as_paragraph:)
          end
        end
      end
    end
  end
end
