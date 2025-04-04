module Cms
  module Models
    module DynamicComponents
      module ContentBlocks
        class Link
          attr_accessor :link_text, :url

          def initialize(link_text:, url:)
            @link_text = link_text
            @url = url
          end

          def render
            Cms::LinkComponent.new(link_text:, url:)
          end
        end
      end
    end
  end
end
