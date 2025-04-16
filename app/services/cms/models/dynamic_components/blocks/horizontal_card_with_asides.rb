module Cms
  module Models
    module DynamicComponents
      module Blocks
        class HorizontalCardWithAsides < HasAsides
          attr_accessor :text, :button, :background_color, :color_theme

          def initialize(text:, button:, aside_sections:, background_color:, color_theme:)
            super(aside_sections)
            @text = text
            @button = button
            @background_color = background_color
            @color_theme = color_theme
          end

          def render
            Cms::HorizontalCardWithAsidesComponent.new(text:, button:, aside_sections:, background_color:, color_theme:)
          end
        end
      end
    end
  end
end
