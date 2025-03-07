module Cms
  module DynamicComponents
    module ContentBlocks
      class HorizontalLinkCard
        attr_accessor :title, :card_content, :link_url, :theme

        def initialize(title:, card_content:, link_url:, theme:)
          @title = title
          @card_content = card_content
          @link_url = link_url
          @theme = theme
        end

        def render
          HorizontalLinkCardComponent.new(title:, card_content:, link_url:, theme:)
        end
      end
    end
  end
end
