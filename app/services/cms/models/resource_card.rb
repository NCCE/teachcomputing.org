module Cms
  module Models
    class ResourceCard
      attr_accessor :title, :icon, :colour_theme, :body_text, :button_text, :button_link

      def initialize(title:, icon:, colour_theme:, body_text:, button_text:, button_link:)
        @title = title
        @icon = icon
        @colour_theme = colour_theme
        @body_text = body_text
        @button_text = button_text
        @button_link = button_link
      end

      def render
        CmsResourceCardComponent.new(title:, icon:, colour_theme:, body_text:, button_text:, button_link:)
      end
    end
  end
end
