module Cms
  module Providers
    module Strapi
      module Mocks
        class FullWidthBanner < StrapiMock
          strapi_component "blocks.full-width-banner"
          attribute(:textContent) { RichBlocks.generate_data }
          attribute(:image) { Mocks::Image.generate_data }
          attribute(:imageLink) { Faker::Internet.url }
          attribute(:backgroundColor) { {name: "white"} }
          attribute(:imageSide) { "right" }
          attribute(:buttons) { nil }
          attribute(:i_belong_flag) { false }
          attribute(:corner_flourish) { false }
        end
      end
    end
  end
end
