module Cms
  module DynamicComponents
    module ContentBlocks
      class Icon
        attr_accessor :text, :image

        def initialize(text:, image:)
          @text = text
          @image = image
        end
      end
    end
  end
end
