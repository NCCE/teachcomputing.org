module Cms
  module Models
    module ImageComponents
      class FeaturedImage
        attr_accessor :image

        def initialize(url:, alt:, caption:, formats:, size: :large)
          @image = Image.new(url:, alt:, caption:, formats:, default_size: size)
        end

        def render
          FeaturedImageComponent.new(image)
        end
      end
    end
  end
end
