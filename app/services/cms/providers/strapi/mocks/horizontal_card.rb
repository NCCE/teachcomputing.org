module Cms
  module Providers
    module Strapi
      module Mocks
        class HorizontalCard < StrapiMock
          strapi_component "blocks.horizontal-card"

          attribute(:title) { Faker::Lorem.words(number: 5) }
          attribute(:bodyText) { RichBlocks.generate_data }
          attribute(:image) { Image.generate_data }
          attribute(:imageLink) { nil }
          attribute(:colourTheme) { nil }
          attribute(:iconBlock) { IconBlocks.generate_data }
        end
      end
    end
  end
end
