module Cms
  module Models
    module DynamicComponents
      module ContentBlocks
        class AccordionBlock
          attr_accessor :heading, :summary_text, :text_content

          def initialize(heading:, summary_text:, text_content:)
            @heading = heading
            @summary_text = summary_text
            @text_content = text_content
          end

          def render
            Cms::AccordionBlockComponent.new(heading:, summary_text:, text_content:)
          end
        end
      end
    end
  end
end
