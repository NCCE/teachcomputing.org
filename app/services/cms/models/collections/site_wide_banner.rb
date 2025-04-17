module Cms
  module Models
    module Collections
      class SiteWideBanner
        attr_reader :text_content

        def initialize(text_content:)
          @text_content = text_content
        end

        def render
          Cms::SiteWideBannerComponent.new(text_content:)
        end
      end
    end
  end
end
