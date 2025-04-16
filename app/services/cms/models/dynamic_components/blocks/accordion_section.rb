module Cms
  module Models
    module DynamicComponents
      module Blocks
        class AccordionSection
          attr_accessor :id, :title, :background_color, :accordion_blocks

          def initialize(id:, title:, background_color:, accordion_blocks:)
            @id = id
            @title = title
            @background_color = background_color
            @accordion_blocks = accordion_blocks
          end

          def render
            Cms::AccordionSectionComponent.new(id:, title:, background_color:, accordion_blocks:)
          end
        end
      end
    end
  end
end
