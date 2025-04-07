module Cms
  module Providers
    module Strapi
      module Mocks
        module DynamicComponents
          module Blocks
            class TwoColumnVideoSection < StrapiMock
              strapi_component "blocks.two-column-video-section"

              attribute(:leftColumnContent) { Text::RichBlocks.generate_data }
              attribute(:rightColumnContent) { Text::RichBlocks.generate_data }
              attribute(:bkColor) { Meta::ColorScheme.generate_data(name: "light_grey") }
              attribute(:boxColor) { Meta::ColorScheme.generate_data(name: "white") }
              attribute(:video) { DynamicComponents::ContentBlocks::EmbeddedVideo.generate_data }
              attribute(:leftColumnButton) { DynamicComponents::Buttons::NcceButton.generate_data }
            end
          end
        end
      end
    end
  end
end
