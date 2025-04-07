module Cms
  module Providers
    module Strapi
      module Mocks
        module DynamicComponents
          module Blocks
            class FullWidthBanner < StrapiMock
              strapi_component "blocks.full-width-banner"
              attribute(:textContent) { Text::RichBlocks.generate_data }
              attribute(:image) { Images::Image.generate_data }
              attribute(:imageLink) { Faker::Internet.url }
              attribute(:backgroundColor) { {name: "white"} }
              attribute(:boxColor) { {name: "white"} }
              attribute(:imageSide) { "right" }
              attribute(:buttons) { nil }
              attribute(:iBelongFlag) { false }
              attribute(:cornerFlourish) { false }
              attribute(:imageFit) { false }
            end
          end
        end
      end
    end
  end
end
