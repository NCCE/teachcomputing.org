module Cms
  module Models
    class PageTitle
      attr_accessor :title, :sub_text, :title_image

      def initialize(title:, sub_text:, title_image: nil)
        @title = title
        @sub_text = sub_text
        @title_image = title_image
      end

      def render
        CmsPageTitleComponent.new(title:, sub_text:, title_image:)
      end
    end
  end
end
