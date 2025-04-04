module Cms
  module Providers
    module Strapi
      module Mocks
        module Text
          class TextBlock < StrapiMock
            strapi_component "content-blocks.text-block"

            attribute(:textContent) { Text::RichBlocks.generate_data }
          end
        end
      end
    end
  end
end
