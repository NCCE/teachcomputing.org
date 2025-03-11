module Cms
  module Providers
    module Strapi
      module Mocks
        module DynamicComponents
          module Blocks
            class IBelongPictureCardSection < StrapiMock
              strapi_component "blocks.i-belong-picture-card-section"

              attribute(:sectionTitle) { Faker::Lorem.sentence }
              attribute(:iBelongCards) { Array.new(3) { IBelongPictureCard.generate_data } }
            end
          end
        end
      end
    end
  end
end
