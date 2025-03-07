module Cms
  module Providers
    module Strapi
      module Mocks
        module DynamicComponents
          module Blocks
            class FeaturedBlogs < StrapiMock
              strapi_component "blocks.featured-blogs"

              attribute(:title) { Faker::Lorem.sentence }
            end
          end
        end
      end
    end
  end
end
