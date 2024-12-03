module Cms
  module Models
    class Aside
      attr_reader :title, :show_heading_line, :aside_icons, :title_icon

      def initialize(title:, dynamic_content:, show_heading_line:, aside_icons:, title_icon:)
        @title = title
        @dynamic_content = dynamic_content
        @show_heading_line = show_heading_line
        @aside_icons = aside_icons
        @title_icon = title_icon
      end

      def render
        AsideComponent.new(
          title:,
          title_icon:,
          cms_content: @dynamic_content,
          show_heading_line:,
          aside_icons:
        )
      end
    end
  end
end
