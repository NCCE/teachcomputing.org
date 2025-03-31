module Cms
  module DynamicComponents
    module ContentBlocks
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
end
