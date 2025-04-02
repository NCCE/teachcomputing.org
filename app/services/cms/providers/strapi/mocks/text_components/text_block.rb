module Cms
  module Providers
    module Strapi
      module Mocks
        module TextComponents
          class TextBlock < StrapiMock
            strapi_component "content-blocks.text-block"

            attribute(:textContent) { TextComponents::RichBlocks.generate_data }
          end
        end
      end
    end
  end
end
