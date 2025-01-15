module Cms
  module Models
    class TextBlock
      attr_accessor :blocks, :with_wrapper

      def initialize(blocks:, with_wrapper: true, **options)
        @blocks = blocks
        @with_wrapper = with_wrapper
        @options = options
      end

      def render
        Cms::RichTextBlockComponent.new(blocks:, with_wrapper:, **@options)
      end
    end
  end
end
