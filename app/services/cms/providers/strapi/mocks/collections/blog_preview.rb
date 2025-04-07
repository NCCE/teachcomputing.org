module Cms
  module Providers
    module Strapi
      module Mocks
        module Collections
          class BlogPreview < StrapiMock
            attribute(:slug) { Faker::Internet.slug }
            attribute(:publishDate) { Faker::Date.backward.to_s }
            attribute(:excerpt) { Faker::Lorem.paragraph }
            attribute(:title) { Faker::Lorem.sentence }
            attribute(:featuredImage) { {data: Images::Image.generate_raw_data} }
          end
        end
      end
    end
  end
end
