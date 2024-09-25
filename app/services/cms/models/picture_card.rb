module Cms
  module Models
    class PictureCard
      attr_accessor :image, :title, :body_text, :link

      def initialize(image:, title:, body_text:, link: nil)
        @image = image
        @title = title
        @body_text = body_text
        @link = link
      end

      def render
        CmsPictureCardComponent.new(image:, title:, body_text:, link:)
      end
    end
  end
end
