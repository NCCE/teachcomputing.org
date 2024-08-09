module Cms
  module Models
    class Aside
      attr_reader :title, :content

      def initialize(title:, content:, files:)
        @title = title
        @content = content
        @files = files
      end

      def render
        AsideComponent.new(
          title:,
          cms_blocks: @content,
          cms_files: @files
        )
      end
    end
  end
end
