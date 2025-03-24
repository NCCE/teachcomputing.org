module Cms
  module DynamicComponents
    module Blocks
      class FeedbackBanner
        attr_accessor :title, :button

        def initialize(title:, button:)
          @title = title
          @button = button
        end

        def render
          Cms::FeedbackBannerComponent.new(title:, button:)
        end
      end
    end
  end
end
