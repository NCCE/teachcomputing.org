module Cms
  module Models
    module DynamicComponents
      module Blocks
        class AccordionSection
          attr_accessor :title, :bk_color, :accordion_block

          def initialize(title:, bk_color:, accordion_block:)
            @title = title
            @bk_color = bk_color
            @accordion_block = accordion_block
          end

          def render
            Cms::AccordionSectionComponent.new(title:, bk_color:, accordion_block:)
          end
        end
      end
    end
  end
end
