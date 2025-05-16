module Cms
  module Models
    module Meta
      class Footer
        attr_accessor :image

        def initialize(image:)
          @image = image
        end

        def render
          Cms::FooterComponent.new(link_block:)
        end
      end
    end
  end
end
