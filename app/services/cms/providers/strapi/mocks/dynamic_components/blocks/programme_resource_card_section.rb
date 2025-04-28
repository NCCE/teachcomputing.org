module Cms
  module Providers
    module Strapi
      module Mocks
        module DynamicComponents
          module Blocks
            class ProgrammeResourceCardSection < StrapiMock
              strapi_component "blocks.programme-resource-card-section"

              attribute(:sectionTitle) { Faker::Lorem.sentence }
              attribute(:introText) { Text::RichBlocks.generate_data }
              attribute(:cardsPerRow) { 3 }
              attribute(:prog) { {data: {attributes: {slug: "i-belong"}}} }
              attribute(:resourceCards) { Array.new(3) { DynamicComponents::ContentBlocks::ProgrammeResourceCard.generate_data } }
            end
          end
        end
      end
    end
  end
end
