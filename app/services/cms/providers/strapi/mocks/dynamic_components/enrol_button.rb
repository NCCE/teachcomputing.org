module Cms
  module Providers
    module Strapi
      module Mocks
        module DynamicComponents
          class EnrolButton < StrapiMock
            strapi_component "content-blocks.enrol-button"

            attribute(:buttonText) { Faker::Lorem.word }
            attribute(:programme) { {data: {attributes: {slug: "primary-certificate"}}} }
          end
        end
      end
    end
  end
end
