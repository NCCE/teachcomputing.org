module Cms
  module Providers
    module Strapi
      module Mocks
        class Link < StrapiMock
          strapi_component "content-blocks.link"

          attribute(:linkText) { Faker::Lorem.word }
          attribute(:url) { Faker::Internet.url }
        end
      end
    end
  end
end
