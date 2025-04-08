module Cms
  module Providers
    module Strapi
      module Mocks
        module DynamicComponents
          module Blocks
            class TextWithAsides < StrapiMock
              strapi_component "blocks.text-with-asides"

              attribute(:textContent) { Text::RichBlocks.generate_data }
              attribute(:asideSections) { Collections::AsideSection.generate_aside_list }
              attribute(:bkColor) { Meta::ColorScheme.generate_data(name: "light_grey") }
            end
          end
        end
      end
    end
  end
end
