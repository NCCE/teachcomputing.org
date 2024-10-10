module Cms
  module Providers
    module Strapi
      module Mocks
        class ContentBlock < StrapiMock
          strapi_component "content-blocks.text-block"

          attribute(:content) { RichBlocks.generate_data }
        end
      end
    end
  end
end
