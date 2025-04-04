module Cms
  module Models
    module Meta
      class Seo
        attr_accessor :title, :description

        def initialize(title:, description:, featured_image:)
          @title = title
          @description = description
          @featured_image = featured_image
        end

        def render
          SeoBlockComponent.new(title:, description:, featured_image: @featured_image)
        end
      end
    end
  end
end
