module Cms
  module Models
    module DynamicComponents
      module Blocks
        class HorizontalCard
          attr_accessor :title, :body_blocks, :image, :image_link, :color_theme, :icon_block, :spacing, :external_title, :background_color, :buttons

          def initialize(title:, body_blocks:, image:, image_link:, color_theme:, icon_block:, spacing:, external_title:, background_color:, buttons:)
            @title = title
            @body_blocks = body_blocks
            @image = image
            @image_link = image_link
            @color_theme = color_theme
            @icon_block = icon_block
            @spacing = spacing
            @external_title = external_title
            @background_color = background_color
            @buttons = buttons
          end

          def render
            Cms::HorizontalCardComponent.new(title:, body_blocks:, image:, image_link:, color_theme:, icon_block:, spacing:, external_title:, background_color:, buttons:)
          end
        end
      end
    end
  end
end
