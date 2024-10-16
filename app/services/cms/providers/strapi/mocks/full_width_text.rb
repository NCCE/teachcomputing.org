module Cms
  module Providers
    module Strapi
      module Mocks
        class FullWidthText < StrapiMock
          strapi_component "blocks.full-width-text"

          attribute(:textContent) { RichBlocks.generate_data }
        end
      end
    end
  end
end
