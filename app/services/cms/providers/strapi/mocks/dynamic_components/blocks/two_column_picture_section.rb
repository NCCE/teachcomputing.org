module Cms
  module Providers
    module Strapi
      module Mocks
        module DynamicComponents
          module Blocks
            class TwoColumnPictureSection < StrapiMock
              strapi_component "blocks.two-column-picture-section"

              attribute(:text) { RichBlocks.generate_data }
              attribute(:image) { Image.generate_data }
              attribute(:imageSide) { "left" }
              attribute(:bkColor) { ColorScheme.generate_data(name: "light_grey") }
            end
          end
        end
      end
    end
  end
end
