module Cms
  module Models
    module BlogComponents
      class BlogPreview
        attr_reader :title, :excerpt, :publish_date, :featured_image, :slug

        def initialize(title:, excerpt:, publish_date:, featured_image:, slug:)
          @title = title
          @excerpt = excerpt
          @publish_date = Time.parse(publish_date).in_time_zone("Europe/London").to_datetime
          @featured_image = featured_image
          @slug = slug
        end

        def render
          BlogPreviewComponent.new(
            title:,
            excerpt:,
            publish_date:,
            featured_image:,
            slug:
          )
        end
      end
    end
  end
end
