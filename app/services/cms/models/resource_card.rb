module Cms
  module Models
    class ResourceCard
      attr_accessor :title, :icon, :colour_theme, :body_text

      def initialize(title:, icon:, colour_theme:, body_text:)
        @title = title
        @icon = icon
        @colour_theme = colour_theme
        @body_text = body_text
      end

      def render
        CmsResourceCardComponent.new(title:, icon:, colour_theme:, body_text:)
      end
    end
  end
end
