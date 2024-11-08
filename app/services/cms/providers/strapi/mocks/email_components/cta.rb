module Cms
  module Providers
    module Strapi
      module Mocks
        module EmailComponents
          class Cta < StrapiEmailMock
            strapi_component "email-content.cta"
            attribute(:text) { Faker::Lorem.sentence }
            attribute(:link) { Faker::Internet.url }
          end
        end
      end
    end
  end
end
