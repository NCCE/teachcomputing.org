# frozen_string_literal: true

class CmsPageTitleComponent < ViewComponent::Base
  def initialize(title:, sub_text: nil, title_image: nil, title_video_url: nil)
    @title = title
    @sub_text = sub_text
    @title_image = title_image
    @title_video_url = title_video_url
  end
end
