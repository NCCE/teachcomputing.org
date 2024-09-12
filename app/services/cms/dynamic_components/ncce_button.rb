module Cms
  module DynamicComponents
    class NcceButton
      attr_accessor :title, :link

      def initialize(title:, link:)
        @title = title
        @link = link
      end

      def render
        CmsNcceButtonComponent.new(title:, link:, colour: :white)
      end
    end
  end
end
