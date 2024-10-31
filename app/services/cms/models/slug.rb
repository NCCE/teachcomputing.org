module Cms
  module Models
    class Slug
      attr_accessor :slug

      def initialize(slug:)
        @slug = slug
      end

      def render
        raise StandardError("Not available on slug models")
      end
    end
  end
end
