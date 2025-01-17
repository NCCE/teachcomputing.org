module Cms
  module DynamicComponents
    class NcceButton
      attr_accessor :title, :link, :color

      def initialize(title:, link:, color:)
        @title = title
        @link = link
        @color = color
      end

      def render
        Cms::NcceButtonComponent.new(title:, link:, color:)
      end
    end
  end
end
