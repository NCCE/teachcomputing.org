module Cms
  module DynamicComponents
    class EmbeddedVideo
      attr_accessor :url

      def initialize(url:)
        @url = url
      end

      def render
        Cms::EmbeddedVideoComponent.new(url:)
      end
    end
  end
end
