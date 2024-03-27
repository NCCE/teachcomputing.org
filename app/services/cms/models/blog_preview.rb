module Cms
  module Models
    class BlogPreview
      def initialize(title, excerpt, publish_date, featured_image, slug)
        @title = title
        @excerpt = excerpt
        @publish_date = publish_date
        @featured_image = featured_image
        @slug = slug
      end

      def render
        BlogPreviewComponent.new(
          title: @title,
          excerpt: @excerpt,
          publish_date: @publish_date,
          featured_image: @featured_image,
          slug: @slug
        )
      end
    end
  end
end
