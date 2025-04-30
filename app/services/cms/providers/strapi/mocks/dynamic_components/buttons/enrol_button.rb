module Cms
  module Providers
    module Strapi
      module Mocks
        module DynamicComponents
          module Buttons
            class EnrolButton < StrapiMock
              strapi_component "content-blocks.enrol-button"

              attribute(:loggedOutButtonText) { Faker::Lorem.word }
              attribute(:loggedInButtonText) { Faker::Lorem.word }
              attribute(:programme) { {data: {attributes: {slug: "primary-certificate"}}} }
            end
          end
        end
      end
    end
  end
end
