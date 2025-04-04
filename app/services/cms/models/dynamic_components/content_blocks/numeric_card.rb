module Cms
  module Models
    module DynamicComponents
      module ContentBlocks
        class NumericCard
          attr_accessor :title, :text_content, :number

          def initialize(title:, text_content:, number:)
            @title = title
            @text_content = text_content
            @number = number
          end

          def render
            Cms::NumericCardComponent.new(
              title:,
              text_content:,
              number:
            )
          end
        end
      end
    end
  end
end
