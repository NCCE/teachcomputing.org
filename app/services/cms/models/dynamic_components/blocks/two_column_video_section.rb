module Cms
  module Models
    module DynamicComponents
      module Blocks
        class TwoColumnVideoSection
          attr_accessor :left_column_content, :video, :right_column_content, :background_color, :left_column_button, :box_color, :video_side, :section_title

          def initialize(left_column_content:, video:, right_column_content:, background_color:, left_column_button:, box_color:, video_side:, section_title:)
            @left_column_content = left_column_content
            @video = video
            @right_column_content = right_column_content
            @background_color = background_color
            @left_column_button = left_column_button
            @box_color = box_color
            @video_side = video_side
            @section_title = section_title
          end

          def render
            Cms::TwoColumnVideoSectionComponent.new(
              left_column_content:,
              video:,
              right_column_content:,
              background_color:,
              left_column_button:,
              box_color:,
              section_title:
            )
          end
        end
      end
    end
  end
end
