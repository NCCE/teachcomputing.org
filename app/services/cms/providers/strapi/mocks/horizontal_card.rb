module Cms
  module Providers
    module Strapi
      module Mocks
        class HorizontalCard < StrapiMock
          strapi_component "blocks.horizontal-card"

          attribute(:title) { Faker::Lorem.words(number: 5) }
          attribute(:textContent) { RichBlocks.generate_data }
          attribute(:image) { Image.generate_data }
          attribute(:imageLink) { nil }
          attribute(:colorTheme) { nil }
          attribute(:iconBlock) { IconBlocks.generate_data }
          attribute(:spacing) { "First" }
          attribute(:externalTitle) { nil }
        end
      end
    end
  end
end
