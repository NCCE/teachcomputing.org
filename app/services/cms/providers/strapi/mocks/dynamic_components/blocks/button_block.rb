module Cms
  module Providers
    module Strapi
      module Mocks
        module DynamicComponents
          module Blocks
            class ButtonBlock < StrapiMock
              strapi_component "blocks.button-block"

              attribute(:buttons) { Array.new(3) { Mocks::DynamicComponents::Buttons::NcceButton.generate_data } }
              attribute(:bkColor) { Meta::ColorScheme.generate_data(name: "light_grey") }
              attribute(:padding) { false }
              attribute(:alignment) { "left" }
              attribute(:fullWidth) { false }
            end
          end
        end
      end
    end
  end
end
