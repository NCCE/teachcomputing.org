module Cms
  module Providers
    module Strapi
      module Mocks
        module DynamicComponents
          module Blocks
            class FullWidthText < StrapiMock
              strapi_component "blocks.full-width-text"

              attribute(:textContent) { Text::RichBlocks.generate_data }
            end
          end
        end
      end
    end
  end
end
