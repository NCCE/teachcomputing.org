module Cms
  module Models
    module DynamicComponents
      module Blocks
        class SplitHorizontalCard
          attr_accessor :card_content, :aside_content, :aside_icon, :aside_title, :section_title, :color_theme, :background_color

          def initialize(card_content:, aside_content:, aside_icon: nil, aside_title: nil, section_title: nil, color_theme: nil, background_color: nil)
            @card_content = card_content
            @aside_content = aside_content
            @aside_icon = aside_icon
            @aside_title = aside_title
            @section_title = section_title
            @color_theme = color_theme
            @background_color = background_color
          end

          def render
            Cms::SplitHorizontalCardComponent.new(
              card_content:,
              aside_content:,
              aside_icon:,
              aside_title:,
              section_title:,
              color_theme:,
              background_color:
            )
          end
        end
      end
    end
  end
end
