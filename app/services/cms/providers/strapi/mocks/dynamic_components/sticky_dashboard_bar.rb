module Cms
  module Providers
    module Strapi
      module Mocks
        module DynamicComponents
          class StickyDashboardBar < StrapiMock
            strapi_component "blocks.sticky-dashboard-bar"

            attribute(:programme) { {data: {attributes: {slug: "primary-certificate"}}} }
          end
        end
      end
    end
  end
end
