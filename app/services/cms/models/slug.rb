module Cms
  module Models
    class Slug
      attr_accessor :slug

      def initialize(slug:)
        @slug = slug
      end

      def render
      end
    end
  end
end
