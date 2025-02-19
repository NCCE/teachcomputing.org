module Cms
  module DynamicComponents
    class IconRow
      attr_accessor :icons

      def initialize(icons:)
        @icons = icons
      end

      def render
        Cms::IconRowComponent.new(icons:)
      end
    end
  end
end
