module Cms
  module Providers
    module Strapi
      module Mocks
        class TextBlock < StrapiMock
          strapi_component "content-blocks.text-block"

          attribute(:textContent) { RichBlocks.generate_data }
        end
      end
    end
  end
end
