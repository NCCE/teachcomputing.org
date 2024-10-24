module Cms
  module DynamicComponents
    class NumberedIconList
      attr_accessor :title, :titleIcon, :points

      def initialize(title:, title_icon:, points:)
        @title = title
        @title_icon = title_icon
        @points = points
      end

      def render
        CmsNumberedIconListComponent.new(title:, title_icon:, points:)
      end
    end
  end
end
