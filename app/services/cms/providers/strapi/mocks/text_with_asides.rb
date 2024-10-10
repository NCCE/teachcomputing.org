module Cms
  module Providers
    module Strapi
      module Mocks
        class TextWithAsides < StrapiMock
          strapi_component "blocks.text-with-asides"

          attribute(:blocks) { RichBlocks.generate_data }
          attribute(:asides) { Cms::Mocks::AsideSection.generate_aside_list }
        end
      end
    end
  end
end
