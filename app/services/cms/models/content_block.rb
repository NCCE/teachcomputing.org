module Cms
  module Models
    class ContentBlock
      attr_accessor :blocks

      def initialize(blocks:)
        @blocks = blocks
      end

      def render
        CmsRichTextBlockComponent.new(blocks:, with_wrapper: false)
      end
    end
  end
end
