module Cms
  module Providers
    module Strapi
      module Mocks
        class NumericCardSection < StrapiMock
          strapi_component "blocks.numeric-cards-section"
          attribute(:cardsPerRow) { 3 }
          attribute(:sectionTitle) { Faker::Lorem.sentence }
          attribute(:colorTheme) { nil }
          attribute(:numericCards) { Array.new(3) { NumericCard.generate_data } }
        end
      end
    end
  end
end