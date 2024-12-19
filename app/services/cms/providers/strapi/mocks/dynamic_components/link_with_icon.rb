module Cms
  module Providers
    module Strapi
      module Mocks
        module DynamicComponents
          class LinkWithIcon < StrapiMock
            strapi_component "content-blocks.link-with-icon"

            attribute(:linkText) { Faker::Lorem.sentence }
            attribute(:url) { Faker::Internet.url }
            attribute(:icon) { Cms::Mocks::Image.generate_raw_data }
          end
        end
      end
    end
  end
end
