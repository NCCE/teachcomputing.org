module Cms
  module DynamicComponents
    class NumberedIconList
      attr_accessor :title, :title_icon, :points, :aside_sections

      def initialize(title:, title_icon:, points:, aside_sections:)
        @title = title
        @title_icon = title_icon
        @points = points
        @aside_sections = aside_sections
      end

      def render
        CmsNumberedIconListComponent.new(title:, title_icon:, points:, aside_sections:)
      end
    end
  end
end
