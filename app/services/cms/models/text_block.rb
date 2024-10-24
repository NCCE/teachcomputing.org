module Cms
  module Models
    class TextBlock
      attr_accessor :blocks, :with_wrapper

      def initialize(blocks:, with_wrapper: false)
        @blocks = blocks
        @with_wrapper = with_wrapper
      end

      def render
        CmsRichTextBlockComponent.new(blocks:, with_wrapper:)
      end
    end
  end
end
