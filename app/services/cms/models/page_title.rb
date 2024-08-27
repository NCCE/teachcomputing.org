module Cms
  module Models
    class PageTitle
      attr_accessor :title, :intro_text

      def initialize(title:, intro_text:)
        @title = title
        @intro_text = intro_text
      end

      def render
        CmsPageTitleComponent.new(title:, intro_text:)
      end
    end
  end
end
