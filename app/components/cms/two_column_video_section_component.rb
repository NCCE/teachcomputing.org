# frozen_string_literal: true

class Cms::TwoColumnVideoSectionComponent < ViewComponent::Base
  def initialize(left_column_content:, video:, right_column_content: nil, background_color: nil, left_column_button: nil, box_color: nil, video_side: "left", section_title: nil)
    @left_column_content = left_column_content
    @video = video
    @right_column_content = right_column_content
    @background_color = background_color
    @left_column_button = left_column_button
    @box_color = box_color
    @video_side = video_side
    @section_title = section_title
  end

  def column_classes(side)
    classes = ["tc-row-half"]
    classes << "cms-two-column-video-section-component__video-wrapper" if @video_side == side
    classes
  end

  def content_background_color_classes
    classes = []

    if @box_color
      classes << ["cms-two-column-video-section-component__wrapper--padded", "tc-row"]
      classes << "#{@box_color}-bg"
    else
      classes << ["cms-two-column-video-section-component__wrapper", "tc-row"]
    end
    classes
  end
end
