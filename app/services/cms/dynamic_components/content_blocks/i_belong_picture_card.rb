module Cms
  module DynamicComponents
    module ContentBlocks
      class IBelongPictureCard
        attr_accessor :title, :text_content, :image, :card_links

        def initialize(title:, text_content:, image:, card_links:)
          @title = title
          @text_content = text_content
          @image = image
          @card_links = card_links
        end

        def render
          Cms::IBelongPictureCardComponent.new(title:, text_content:, image:, card_links:)
        end
      end
    end
  end
end
