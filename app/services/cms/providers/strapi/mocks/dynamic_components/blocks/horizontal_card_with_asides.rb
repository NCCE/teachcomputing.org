module Cms
  module Providers
    module Strapi
      module Mocks
        module DynamicComponents
          module Blocks
            class HorizontalCardWithAsides < StrapiMock
              strapi_component "blocks.horizontal-card-with-asides"

              attribute(:textContent) { Text::RichBlocks.generate_data }
              attribute(:bkColor) { Meta::ColorScheme.generate_data(name: "light_grey") }
              attribute(:theme) { Meta::ColorScheme.generate_data(name: "light_grey") }
              attribute(:button) { DynamicComponents::Buttons::NcceButton.generate_data }
              attribute(:asides) { Collections::AsideSection.generate_aside_list }
            end
          end
        end
      end
    end
  end
end
