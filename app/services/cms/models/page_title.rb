module Cms
  module Models
    class PageTitle
      attr_accessor :title, :sub_text, :title_image, :title_video_url

      def initialize(title:, sub_text:, title_image: nil, title_video_url: nil)
        @title = title
        @sub_text = sub_text
        @title_image = title_image
        @title_video_url = title_video_url
      end

      def render
        CmsPageTitleComponent.new(title:, sub_text:, title_image:, title_video_url:)
      end
    end
  end
end
