module Cms
  module Models
    class PageTitle
      attr_accessor :title, :sub_text

      def initialize(title:, sub_text:)
        @title = title
        @sub_text = sub_text
      end

      def render
        CmsPageTitleComponent.new(title:, sub_text:)
      end
    end
  end
end
