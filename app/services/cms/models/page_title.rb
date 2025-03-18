module Cms
  module Models
    class PageTitle
      attr_accessor :title, :sub_text, :title_image, :title_video_url, :background_color, :i_belong_flag

      def initialize(title:, sub_text:, title_image: nil, title_video_url: nil, background_color: nil, i_belong_flag: false)
        @title = title
        @sub_text = sub_text
        @title_image = title_image
        @title_video_url = title_video_url
        @background_color = background_color
        @i_belong_flag = i_belong_flag
      end

      def render
        Cms::PageTitleComponent.new(title:, sub_text:, title_image:, title_video_url:, background_color:, i_belong_flag:)
      end
    end
  end
end
