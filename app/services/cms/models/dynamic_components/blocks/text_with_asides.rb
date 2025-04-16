module Cms
  module Models
    module DynamicComponents
      module Blocks
        class TextWithAsides < HasAsides
          attr_accessor :blocks, :background_color

          def initialize(blocks:, asides:, background_color:)
            super(asides)
            @blocks = blocks
            @background_color = background_color
          end

          def render
            Cms::TextWithAsidesComponent.new(blocks:, asides: @aside_sections, background_color:)
          end
        end
      end
    end
  end
end
