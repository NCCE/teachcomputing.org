module Cms
  module Models
    module DynamicComponents
      module ContentBlocks
        class AccordionBlock
          attr_accessor :id, :heading, :summary_text, :text_content

          def initialize(id:, heading:, summary_text:, text_content:)
            @id = id
            @heading = heading
            @summary_text = summary_text
            @text_content = text_content
          end

          def render
            Cms::AccordionBlockComponent.new(id:, heading:, summary_text:, text_content:)
          end
        end
      end
    end
  end
end
