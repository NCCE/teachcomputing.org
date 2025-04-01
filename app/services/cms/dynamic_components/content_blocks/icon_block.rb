module Cms
  module DynamicComponents
    module ContentBlocks
      class IconBlock
        attr_accessor :icons

        def initialize(icons:)
          @icons = icons
        end

        def render
          Cms::IconBlockComponent.new(icons:)
        end
      end
    end
  end
end
