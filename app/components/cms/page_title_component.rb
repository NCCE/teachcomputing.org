# frozen_string_literal: true

class Cms::PageTitleComponent < ViewComponent::Base
  def initialize(title:, sub_text: nil, title_image: nil, title_video_url: nil, status_message: nil, background_color: nil, i_belong_flag: false)
    @title = title
    @sub_text = sub_text
    @title_image = title_image
    @title_video_url = title_video_url
    @status_message = status_message
    @background_color = background_color
    @i_belong_flag = i_belong_flag
  end

  def background_color_class
    # Default background color unless specified
    return @background_color if @background_color

    "lime-green"
  end
end
