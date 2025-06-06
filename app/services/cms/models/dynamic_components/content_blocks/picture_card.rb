module Cms
  module Models
    module DynamicComponents
      module ContentBlocks
        class PictureCard
          attr_accessor :image, :title, :body_text, :link, :color_theme

          def initialize(image:, title:, body_text:, link: nil, color_theme: nil)
            @image = image
            @title = title
            @body_text = body_text
            @link = link
            @color_theme = color_theme
          end

          def render
            Cms::PictureCardComponent.new(image:, title:, body_text:, link:, color_theme:)
          end
        end
      end
    end
  end
end
