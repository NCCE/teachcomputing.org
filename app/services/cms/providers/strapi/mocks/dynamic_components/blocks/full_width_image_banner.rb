module Cms
  module Providers
    module Strapi
      module Mocks
        module DynamicComponents
          module Blocks
            class FullWidthImageBanner < StrapiMock
              strapi_component "blocks.full-width-image-banner"

              attribute(:backgroundImage) { Cms::Mocks::ImageComponents::Image.generate_raw_data }
              attribute(:overlayTitle) { Faker::Lorem.sentence }
              attribute(:overlayText) { Cms::Mocks::TextComponents::RichBlocks.generate_data }
              attribute(:overlayIcon) { Cms::Mocks::ImageComponents::Image.generate_raw_data }
              attribute(:overlaySide) { "right" }
            end
          end
        end
      end
    end
  end
end
