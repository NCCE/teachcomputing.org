module Cms
  module Models
    class HorizontalCard
      attr_accessor :title, :body_blocks

      def initialize(title:, body_blocks:)
        @title = title
        @body_blocks = body_blocks
      end

      def render
        CmsHorizontalCardComponent.new(title:, body_blocks:)
      end
    end
  end
end
