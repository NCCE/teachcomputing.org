module Cms
  module Providers
    module Strapi
      module Mocks
        module DynamicComponents
          module ContentBlocks
            class SideBanner < StrapiMock
              strapi_component "content-blocks.side-banner"

              attribute(:textContent) { Text::RichBlocks.generate_data }
              attribute(:icon) { nil }
              attribute(:bannerColor) { {data: Meta::ColorScheme.generate_data(name: "orange")} }
            end
          end
        end
      end
    end
  end
end
