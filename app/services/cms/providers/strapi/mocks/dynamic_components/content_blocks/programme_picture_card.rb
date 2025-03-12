module Cms
  module Providers
    module Strapi
      module Mocks
        module DynamicComponents
          module ContentBlocks
            class ProgrammePictureCard < StrapiMock
              strapi_component "blocks.programme-picture-card"

              attribute(:title) { Faker::Lorem.sentence }
              attribute(:textContent) { RichBlocks.generate_data }
              attribute(:image) { {data: Image.generate_raw_data} }
              attribute(:loggedOutLinkTitle) { Faker::Lorem.sentence }
              attribute(:loggedOutLink) { Faker::Internet.url }
              attribute(:enrolledLinkTitle) { Faker::Lorem.sentence }
              attribute(:enrolledLink) { Faker::Internet.url }
              attribute(:notEnrolledLinkTitle) { Faker::Lorem.sentence }
              attribute(:notEnrolledLink) { Faker::Internet.url }
              attribute(:prog) { Programme.i_belong }
            end
          end
        end
      end
    end
  end
end
