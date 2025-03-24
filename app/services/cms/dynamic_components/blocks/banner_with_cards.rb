module Cms
  module DynamicComponents
    module Blocks
      class BannerWithCards
        attr_accessor :title, :text_content, :cards, :background_color

        def initialize(title:, text_content:, cards:, background_color:)
          @title = title
          @text_content = text_content
          @cards = cards
          @background_color = background_color
        end

        def render
          Cms::BannerWithCardsComponent.new(title:, text_content:, cards:, background_color:)
        end
      end
    end
  end
end
