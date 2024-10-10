module Cms
  module Models
    class Aside
      attr_reader :title, :show_heading_line

      def initialize(title:, dynamic_content:, show_heading_line:)
        @title = title
        @dynamic_content = dynamic_content
        @show_heading_line = show_heading_line
      end

      def render
        AsideComponent.new(
          title:,
          cms_content: @dynamic_content,
          show_heading_line:
        )
      end
    end
  end
end
