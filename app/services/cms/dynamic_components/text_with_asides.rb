module Cms
  module DynamicComponents
    class TextWithAsides
      attr_accessor :blocks, :asides

      def initialize(blocks:, asides:)
        @blocks = blocks
        @asides = asides
      end

      def render
        CmsTextWithAsidesComponent.new(blocks:, asides:)
      end
    end
  end
end
