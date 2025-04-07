module Cms
  module Models
    module DynamicComponents
      module ContentBlocks
        class ProgrammePictureCard
          attr_accessor :title, :text_content, :image, :card_links, :programme

          def initialize(title:, text_content:, image:, card_links:, programme: nil)
            @title = title
            @text_content = text_content
            @image = image
            @card_links = card_links
            @programme = programme
          end

          def render
            Cms::ProgrammePictureCardComponent.new(title:, text_content:, image:, card_links:, programme:)
          end
        end
      end
    end
  end
end
