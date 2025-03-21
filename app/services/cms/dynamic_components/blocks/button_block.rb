module Cms
  module DynamicComponents
    module Blocks
      class ButtonBlock
        attr_accessor :buttons, :background_color, :padding, :alignment, :full_width

        def initialize(buttons:, background_color:, padding:, alignment:, full_width:)
          @buttons = buttons
          @background_color = background_color
          @padding = padding
          @alignment = alignment
          @full_width = full_width
        end

        def render
          Cms::ButtonBlockComponent.new(buttons:, background_color:, padding:, alignment:, full_width:)
        end
      end
    end
  end
end
