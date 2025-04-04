module Cms
  module Providers
    module Strapi
      module Mocks
        module DynamicComponents
          module Blocks
            class BannerWithCards < StrapiMock
              strapi_component "blocks.banner-with-cards"

              attribute(:title) { Faker::Lorem.sentence }
              attribute(:textContent) { Text::RichBlocks.generate_data }
              attribute(:bkColor) { nil }
              attribute(:cards) { Array.new(2) { ContentBlocks::HorizontalLinkCard.generate_data } }
            end
          end
        end
      end
    end
  end
end
