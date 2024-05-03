module Cms
  module Models
    class Seo
      attr_accessor :title, :description

      def initialize(title:, description:)
        @title = title
        @description = description
      end

      def render
        SeoBlockComponent.new(title, description)
      end
    end
  end
end
