module Cms
  module Models
    module DynamicComponents
      module Blocks
        class ProgrammeCardWrapper
          attr_accessor :title, :intro_text, :cards_block, :cards_per_row, :background_color, :title_as_paragraph, :programme

          def initialize(title:, intro_text:, cards_block:, cards_per_row:, background_color:, title_as_paragraph:, programme:)
            @title = title
            @intro_text = intro_text
            @cards_block = cards_block
            @cards_per_row = cards_per_row
            @background_color = background_color
            @title_as_paragraph = title_as_paragraph
            @programme = programme
          end

          def render
            Cms::ProgrammeCardWrapperComponent.new(title:, intro_text:, cards_block:, cards_per_row:, background_color:, title_as_paragraph:, programme:)
          end
        end
      end
    end
  end
end
