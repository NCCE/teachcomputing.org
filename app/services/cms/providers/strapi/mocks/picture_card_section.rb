module Cms
  module Providers
    module Strapi
      module Mocks
        class PictureCardSection < StrapiMock
          strapi_component "blocks.picture-card-section"
          attribute(:cardsPerRow) { 3 }
          attribute(:sectionTitle) { Faker::Lorem.sentence }
          attribute(:colourTheme) { nil }
          attribute(:pictureCard) { Array.new(3) { PictureCard.generate_data } }
        end
      end
    end
  end
end
