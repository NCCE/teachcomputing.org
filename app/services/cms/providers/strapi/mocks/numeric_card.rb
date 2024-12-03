module Cms
  module Providers
    module Strapi
      module Mocks
        class NumericCard < StrapiMock
          strapi_component "content-blocks.numeric-card"

          attribute(:title) { nil }
          attribute(:textContent) { RichBlocks.generate_data }
        end
      end
    end
  end
end
