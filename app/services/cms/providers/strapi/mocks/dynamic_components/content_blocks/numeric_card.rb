module Cms
  module Providers
    module Strapi
      module Mocks
        module DynamicComponents
          module ContentBlocks
            class NumericCard < StrapiMock
              strapi_component "content-blocks.numeric-card"

              attribute(:title) { nil }
              attribute(:textContent) { Text::RichBlocks.generate_data }
            end
          end
        end
      end
    end
  end
end
