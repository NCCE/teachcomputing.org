module Cms
  module Providers
    module Strapi
      module Mocks
        class VideoCardsSection < StrapiMock
          strapi_component "blocks.video-cards-section"
          attribute(:cardsPerRow) { 3 }
          attribute(:title) { Faker::Lorem.sentence }
          attribute(:introText) { RichBlocks.generate_data }
          attribute(:bkColor) { ColorScheme.generate_data(name: "light-grey") }
          attribute(:videoCards) { Array.new(3) { DynamicComponents::ContentBlocks::VideoCard.generate_data } }
        end
      end
    end
  end
end
