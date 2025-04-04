module Cms
  module Models
    module DynamicComponents
      module Blocks
        class IconRow
          attr_accessor :icons, :background_color

          def initialize(icons:, background_color:)
            @icons = icons
            @background_color = background_color
          end

          def render
            Cms::IconRowComponent.new(icons:, background_color:)
          end
        end
      end
    end
  end
end
