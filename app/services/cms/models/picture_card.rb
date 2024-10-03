module Cms
  module Models
    class PictureCard
      attr_accessor :image, :title, :body_text, :link, :colour_theme

      def initialize(image:, title:, body_text:, link: nil, colour_theme: nil)
        @image = image
        @title = title
        @body_text = body_text
        @link = link
        @colour_theme = colour_theme
      end

      def render
        CmsPictureCardComponent.new(image:, title:, body_text:, link:, colour_theme:)
      end
    end
  end
end
