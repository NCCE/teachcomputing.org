module Cms
  module Models
    class Aside
      attr_reader :title, :content

      def initialize(title:, content:, files:, dynamic_content:)
        @title = title
        @content = content
        @files = files
        @dynamic_content = dynamic_content
      end

      def render
        AsideComponent.new(
          title:,
          cms_content: @dynamic_content
        )
      end
    end
  end
end
