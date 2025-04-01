module Cms
  module Providers
    module Strapi
      module Mocks
        module DynamicComponents
          module Blocks
            class HorizontalCard < StrapiMock
              strapi_component "blocks.horizontal-card"

              attribute(:title) { Faker::Lorem.words(number: 5) }
              attribute(:textContent) { TextComponents::RichBlocks.generate_data }
              attribute(:image) { ImageComponents::Image.generate_data }
              attribute(:imageLink) { nil }
              attribute(:colorTheme) { nil }
              attribute(:iconBlock) { DynamicComponents::ContentBlocks::IconBlocks.generate_data }
              attribute(:spacing) { "First" }
              attribute(:externalTitle) { nil }
            end
          end
        end
      end
    end
  end
end
