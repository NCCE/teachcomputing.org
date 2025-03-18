module Cms
  module Providers
    module Strapi
      module Mocks
        class ProgrammePictureCardSection < StrapiMock
          strapi_component "blocks.programme-picture-card-section"

          attribute(:sectionTitle) { Faker::Lorem.sentence }
          attribute(:introText) { RichBlocks.generate_data }
          attribute(:cardsPerRow) { 3 }
          attribute(:prog) { {data: {attributes: {slug: "i-belong"}}} }
          attribute(:programmeCards) { Array.new(3) { DynamicComponents::ContentBlocks::ProgrammePictureCard.generate_data } }
        end
      end
    end
  end
end
