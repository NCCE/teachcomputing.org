module Cms
  module DynamicComponents
    class ResourceCard
      attr_accessor :title, :icon, :color_theme, :body_text, :button_text, :button_link

      def initialize(title:, icon:, color_theme:, body_text:, button_text:, button_link:)
        @title = title
        @icon = icon
        @color_theme = color_theme
        @body_text = body_text
        @button_text = button_text
        @button_link = button_link
      end

      def render
        CmsResourceCardComponent.new(title:, icon:, color_theme:, body_text:, button_text:, button_link:)
      end
    end
  end
end