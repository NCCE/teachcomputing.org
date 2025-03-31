module Cms
  module DynamicComponents
    module ContentBlocks
      class LinkedPicture
        attr_accessor :image, :link

        def initialize(image:, link:)
          @image = image
          @link = link
        end

        def render
          Cms::ImageComponent.new(image, show_caption: false, link:)
        end
      end
    end
  end
end
