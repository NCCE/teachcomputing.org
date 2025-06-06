module Cms
  module Providers
    module Strapi
      module Mocks
        module DynamicComponents
          module Blocks
            class TwoColumnPictureSection < StrapiMock
              strapi_component "blocks.two-column-picture-section"

              attribute(:text) { Text::RichBlocks.generate_data }
              attribute(:image) { Images::Image.generate_data }
              attribute(:imageSide) { "left" }
              attribute(:bkColor) { Meta::ColorScheme.generate_data(name: "light_grey") }
              attribute(:banner) { nil }
            end
          end
        end
      end
    end
  end
end
