module Cms
  module Models
    class ContentBlock
      attr_accessor :blocks

      def initialize(blocks)
        @blocks = blocks
      end

      def render
        CmsRichTextBlockComponent.new(blocks: @blocks)
      end
    end
  end
end
