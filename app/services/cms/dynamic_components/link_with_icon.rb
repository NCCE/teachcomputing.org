module Cms
  module DynamicComponents
    class LinkWithIcon
      attr_accessor :link_text, :url, :icon

      def initialize(link_text:, url:, icon:)
        @link_text = link_text
        @url = url
        @icon = icon
      end

      def render
        Cms::LinkWithIconComponent.new(link_text:, url:, icon:)
      end
    end
  end
end
