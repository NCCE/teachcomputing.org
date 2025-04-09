module Cms
  module Models
    module DynamicComponents
      module ContentBlocks
        class SideBanner
          attr_accessor :text_content, :icon, :banner_color, :side

          def initialize(text_content:, icon:, banner_color:)
            @text_content = text_content
            @icon = icon
            @banner_color = banner_color
            @side = 'right'
          end

          def render
            Cms::SideBannerComponent.new(text_content:, icon:, banner_color:, side:)
          end
        end
      end
    end
  end
end
