module Cms
  module Models
    module DynamicComponents
      module ContentBlocks
        class LinkWithIcon
          attr_accessor :link_text, :url, :icon

          def initialize(link_text:, url:, icon:)
            @link_text = link_text
            @url = url
            @icon = icon
          end

          def render(additional_classes: nil)
            Cms::LinkWithIconComponent.new(
              link_text: @link_text,
              url: @url,
              icon: @icon,
              additional_classes: additional_classes
            )
          end
        end
      end
    end
  end
end
