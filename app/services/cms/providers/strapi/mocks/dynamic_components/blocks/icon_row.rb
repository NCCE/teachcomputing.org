module Cms
  module Providers
    module Strapi
      module Mocks
        module DynamicComponents
          module Blocks
            class IconRow < StrapiMock
              strapi_component "blocks.icon-row"

              attribute(:icons) { Array.new(2) { DynamicComponents::ContentBlocks::Icon.generate_data } }
              attribute(:background_color) { {data: MetaComponents::ColorScheme.generate_data} }
            end
          end
        end
      end
    end
  end
end
