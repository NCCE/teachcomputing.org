module Cms
  module Providers
    module Strapi
      module Mocks
        module DynamicComponents
          module Blocks
            class TwoColumnVideoSection < StrapiMock
              strapi_component "blocks.two-column-video-section"

              attribute(:leftColumnContent) { TextComponents::RichBlocks.generate_data }
              attribute(:rightColumnContent) { TextComponents::RichBlocks.generate_data }
              attribute(:bkColor) { MetaComponents::ColorScheme.generate_data(name: "light_grey") }
              attribute(:boxColor) { MetaComponents::ColorScheme.generate_data(name: "white") }
              attribute(:video) { DynamicComponents::ContentBlocks::EmbeddedVideo.generate_data }
              attribute(:leftColumnButton) { DynamicComponents::Buttons::NcceButton.generate_data }
            end
          end
        end
      end
    end
  end
end
