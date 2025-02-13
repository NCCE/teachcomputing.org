module Cms
  module Providers
    module Strapi
      module Mocks
        class ResourceCardSection < StrapiMock
          strapi_component "blocks.resource-card-section"
          attribute(:cardsPerRow) { 3 }
          attribute(:sectionTitle) { Faker::Lorem.sentence }
          attribute(:introText) { RichBlocks.generate_data }
          attribute(:colorTheme) { nil }
          attribute(:resourceCards) { Array.new(3) { ResourceCard.generate_data } }
        end
      end
    end
  end
end
