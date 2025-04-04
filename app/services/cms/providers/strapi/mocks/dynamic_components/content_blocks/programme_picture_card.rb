module Cms
  module Providers
    module Strapi
      module Mocks
        module DynamicComponents
          module ContentBlocks
            class ProgrammePictureCard < StrapiMock
              strapi_component "blocks.programme-picture-card"

              attribute(:title) { Faker::Lorem.sentence }
              attribute(:textContent) { Mocks::Text::RichBlocks.generate_data }
              attribute(:image) { {data: Mocks::Images::Image.generate_raw_data} }
              attribute(:loggedOutLinkTitle) { Faker::Lorem.sentence }
              attribute(:loggedOutLink) { Faker::Internet.url }
              attribute(:enrolledLinkTitle) { Faker::Lorem.sentence }
              attribute(:enrolledLink) { Faker::Internet.url }
              attribute(:notEnrolledLinkTitle) { Faker::Lorem.sentence }
              attribute(:notEnrolledLink) { Faker::Internet.url }
            end
          end
        end
      end
    end
  end
end
