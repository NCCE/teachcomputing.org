module Cms
  module Models
    module DynamicComponents
      module Blocks
        class AccordionSection
          attr_accessor :title, :background_color, :accordion_block

          def initialize(title:, background_color:, accordion_block:)
            @title = title
            @background_color = background_color
            @accordion_block = accordion_block
          end

          def render
            Cms::AccordionSectionComponent.new(title:, background_color:, accordion_block:)
          end
        end
      end
    end
  end
end
