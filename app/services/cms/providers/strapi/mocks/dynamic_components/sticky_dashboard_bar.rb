module Cms
  module Providers
    module Strapi
      module Mocks
        module DynamicComponents
          class StickyDashboardBar < StrapiMock
            strapi_component "blocks.sticky-dashboard-bar"

            attribute(:programmeSlug) { "primary-certificate" }
          end
        end
      end
    end
  end
end
