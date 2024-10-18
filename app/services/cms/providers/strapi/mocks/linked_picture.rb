module Cms
  module Providers
    module Strapi
      module Mocks
        class LinkedPicture < StrapiMock
          strapi_component "content-blocks.linked-picture"

          attribute(:image) { Mocks::Image.generate_raw_data }
          attribute(:link) { Faker::Internet.url }
        end
      end
    end
  end
end
