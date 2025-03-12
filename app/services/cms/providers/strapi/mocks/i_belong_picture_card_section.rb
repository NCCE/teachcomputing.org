module Cms
  module Providers
    module Strapi
      module Mocks
        class IBelongPictureCardSection < StrapiMock
          strapi_component "blocks.i-belong-picture-card-section"

          attribute(:sectionTitle) { Faker::Lorem.sentence }
          attribute(:iBelongCards) { Array.new(3) { DynamicComponents::ContentBlocks::IBelongPictureCard.generate_data } }
        end
      end
    end
  end
end
