module Cms
  module Models
    module MetaComponents
      class WebPagePreview
        attr_reader :title, :description, :slug

        def initialize(title:, description:, slug:)
          @title = title
          @description = description
          @slug = slug
        end

        def render
          # Should not be rendered
        end
      end
    end
  end
end
