# frozen_string_literal: true

class Cms::TwoColumnVideoSectionComponent < ViewComponent::Base
  def initialize(left_column_content:, video:, right_column_content: nil, background_color: nil, left_column_button: nil, box_color: nil, video_side: "left")
    @left_column_content = left_column_content
    @video = video
    @right_column_content = right_column_content
    @background_color = background_color
    @left_column_button = left_column_button
    @box_color = box_color
    @video_side = video_side
  end

  def left_column_classes
    classes = ["tc-row-half"]
    classes << "cms-two-column-video-section-component__video-wrapper" if @video_side == "left"
    classes
  end

  def right_column_classes
    classes = ["tc-row-half"]
    classes << "cms-two-column-video-section-component__video-wrapper" if @video_side == "right"
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
