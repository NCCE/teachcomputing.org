# frozen_string_literal: true

class Cms::PageTitleComponent < ViewComponent::Base
  def initialize(title:, sub_text: nil, title_image: nil, title_video_url: nil, status_message: nil)
    @title = title
    @sub_text = sub_text
    @title_image = title_image
    @title_video_url = title_video_url
    @status_message = status_message
  end
end
