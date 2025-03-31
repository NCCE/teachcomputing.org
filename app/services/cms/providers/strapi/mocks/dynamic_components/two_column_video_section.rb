module Cms
  module Providers
    module Strapi
      module Mocks
        module DynamicComponents
          class TwoColumnVideoSection < StrapiMock
            strapi_component "blocks.two-column-video-section"

            attribute(:leftColumnContent) { RichBlocks.generate_data }
            attribute(:rightColumnContent) { RichBlocks.generate_data }
            attribute(:bkColor) { ColorScheme.generate_data(name: "light_grey") }
            attribute(:boxColor) { ColorScheme.generate_data(name: "white") }
            attribute(:video) { Cms::Mocks::DynamicComponents::ContentBlocks::EmbeddedVideo.generate_data }
            attribute(:leftColumnButton) { Cms::Mocks::NcceButton.generate_data }
          end
        end
      end
    end
  end
end
