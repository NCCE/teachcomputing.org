module Cms
  module Providers
    module Strapi
      module Mocks
        module Collections
          class Blog < StrapiMock
            attribute(:slug) { Faker::Internet.slug }
            attribute(:content) { Text::RichBlocks.generate_data }
            attribute(:publishDate) { Faker::Date.backward }
            attribute(:excerpt) { Faker::Lorem.paragraph }
            attribute(:seo) { Meta::Seo.generate_raw_data }
            attribute(:title) { Faker::Lorem.sentence }
            attribute(:featuredImage) { {data: Images::Image.generate_raw_data} }
          end
        end
      end
    end
  end
end
