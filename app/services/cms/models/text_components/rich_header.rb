module Cms
  module Models
    module TextComponents
      class RichHeader
        # Used in enrichment, headers needed to support italics and bold etc
        # Uses Strapi's block system, but we will only use the first block
        # We might need extra cleaning in the future, but comms have been instructed to ensure only simple format tools are applied

        attr_reader :plain_string

        def initialize(blocks:)
          @blocks = blocks

          @content = @blocks.first
          @plain_string = extract_text(@content)
        end

        def extract_text(block)
          if block[:type] == "text"
            block[:text]
          else
            block[:children].map { extract_text(_1) }.join(" ")
          end
        end

        def render
          Cms::RichTextBlockComponent.new(blocks: Array.wrap(@content))
        end
      end
    end
  end
end
