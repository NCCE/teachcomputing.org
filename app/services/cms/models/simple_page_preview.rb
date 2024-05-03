module Cms
  module Models
    class SimplePagePreview
      attr_reader :title, :slug, :excerpt

      def initialize(title:, slug:, excerpt:)
        @title = title
        @slug = slug
        @excerpt = excerpt
      end
    end
  end
end
