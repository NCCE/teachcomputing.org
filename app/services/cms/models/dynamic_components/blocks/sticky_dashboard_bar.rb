module Cms
  module Models
    module DynamicComponents
      module Blocks
        class StickyDashboardBar
          attr_accessor :programme_slug

          def initialize(programme_slug:)
            @programme_slug = programme_slug
          end

          def render
            Cms::StickyDashboardBarComponent.new(programme_slug:)
          end
        end
      end
    end
  end
end
