module Cms
  module Models
    class Slug
      attr_accessor :slug

      def initialize(slug:)
        @slug = slug
      end

      def render
        # has no render method, this exists just to provide data to model
      end
    end
  end
end
