module Cms
  module DynamicComponents
    module Blocks
      class TwoColumnVideoSection
        attr_accessor :left_column_content, :video, :right_column_content, :background_color, :left_column_button, :box_color

        def initialize(left_column_content:, video:, right_column_content:, background_color:, left_column_button:, box_color:)
          @left_column_content = left_column_content
          @video = video
          @right_column_content = right_column_content
          @background_color = background_color
          @left_column_button = left_column_button
          @box_color = box_color
        end

        def render
          Cms::TwoColumnVideoSectionComponent.new(
            left_column_content:,
            video:,
            right_column_content:,
            background_color:,
            left_column_button:,
            box_color:
          )
        end
      end
    end
  end
end
