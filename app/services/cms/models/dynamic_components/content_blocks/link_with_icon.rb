module Cms
  module Models
    module DynamicComponents
      module ContentBlocks
        class LinkWithIcon
          attr_accessor :link_text, :url, :icon, :additional_classes

          def initialize(link_text:, url:, icon:, additional_classes:)
            @link_text = link_text
            @url = url
            @icon = icon
            @additional_classes = additional_classes
          end

          def render
            Cms::LinkWithIconComponent.new(link_text:, url:, icon:, additional_classes:)
          end
        end
      end
    end
  end
end
