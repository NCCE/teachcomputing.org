module Cms
  module DynamicComponents
    class TwoColumnVideoSection
      attr_accessor :left_column_content, :video, :right_column_content, :background_color

      def initialize(left_column_content:, video:, right_column_content:, background_color:)
        @left_column_content = left_column_content
        @video = video
        @right_column_content = right_column_content
        @background_color = background_color
      end

      def render
        Cms::TwoColumnVideoSectionComponent.new(left_column_content:, video:, right_column_content:, background_color:)
      end
    end
  end
end
