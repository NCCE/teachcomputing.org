module Cms
  module Providers
    module Strapi
      module Mocks
        class TextWithAsides < StrapiMock
          strapi_component "blocks.text-with-asides"

          attribute(:textContent) { RichBlocks.generate_data }
          attribute(:asides) { Cms::Mocks::AsideSection.generate_aside_list }
          attribute(:bkColor) { ColorScheme.generate_data(name: "light_grey") }
        end
      end
    end
  end
end
