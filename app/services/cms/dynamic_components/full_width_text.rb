module Cms
  module DynamicComponents
    class FullWidthText
      attr_accessor :blocks

      def initialize(blocks:)
        @blocks = blocks
      end

      def render
        CmsFullWidthTextBlockComponent.new(blocks:)
      end
    end
  end
end
