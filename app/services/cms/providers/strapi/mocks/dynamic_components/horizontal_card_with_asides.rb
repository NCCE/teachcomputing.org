module Cms
  module Providers
    module Strapi
      module Mocks
        module DynamicComponents
          class HorizontalCardWithAsides < StrapiMock
            strapi_component "blocks.horizontal-card-with-asides"

            attribute(:textContent) { RichBlocks.generate_data }
            attribute(:bkColor) { ColorScheme.generate_data(name: "light_grey") }
            attribute(:theme) { ColorScheme.generate_data(name: "light_grey") }
            attribute(:button) { Cms::Mocks::NcceButton.generate_data }
            attribute(:asides) { Cms::Mocks::AsideSection.generate_aside_list }
          end
        end
      end
    end
  end
end
