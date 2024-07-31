module Cms
  module Models
    class SimpleTitle
      attr_accessor :title

      def initialize(title:)
        @title = title
      end

      def render
        HeroComponent.new(title: title)
      end
    end
  end
end
