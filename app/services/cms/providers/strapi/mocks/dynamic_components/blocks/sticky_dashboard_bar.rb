module Cms
  module Providers
    module Strapi
      module Mocks
        module DynamicComponents
          module Blocks
            class StickyDashboardBar < StrapiMock
              strapi_component "blocks.sticky-dashboard-bar"

              attribute(:programme) { {slug: "primary-certificate"} }
            end
          end
        end
      end
    end
  end
end
