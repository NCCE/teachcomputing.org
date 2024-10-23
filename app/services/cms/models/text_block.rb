module Cms
  module Models
    class TextBlock
      attr_accessor :blocks, :with_wrapper

      def initialize(blocks:, with_wrapper: false, **options)
        @blocks = blocks
        @with_wrapper = with_wrapper
        @options = options
      end

      def render
        CmsRichTextBlockComponent.new(blocks:, with_wrapper:, **@options)
      end
    end
  end
end
