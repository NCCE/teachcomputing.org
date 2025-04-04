module Cms
  module Providers
    module Strapi
      module Mocks
        module DynamicComponents
          module Blocks
            class FullWidthImageBanner < StrapiMock
              strapi_component "blocks.full-width-image-banner"

              attribute(:backgroundImage) { Images::Image.generate_raw_data }
              attribute(:overlayTitle) { Faker::Lorem.sentence }
              attribute(:overlayText) { Text::RichBlocks.generate_data }
              attribute(:overlayIcon) { Images::Image.generate_raw_data }
              attribute(:overlaySide) { "right" }
            end
          end
        end
      end
    end
  end
end
