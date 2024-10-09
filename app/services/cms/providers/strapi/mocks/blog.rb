module Cms
  module Providers
    module Strapi
      module Mocks
        class Blog
          def self.generate_data(slug: nil, publish_date: nil, published: true, title: nil, excerpt: nil, seo: {})
            {
              slug: slug.presence || Faker::Internet.slug,
              content: RichBlocks.generate_data,
              publishDate: publish_date.presence || Faker::Date.backward,
              excerpt: excerpt.presence || Faker::Lorem.paragraph,
              seo: Seo.generate_raw_data(**seo),
              title: title.presence || Faker::Lorem.sentence,
              featuredImage: {data: Image.generate_raw_data},
              publishedAt: published ? Faker::Date.backward : nil,
              createdAt: Faker::Date.backward,
              updatedAt: Faker::Date.backward
            }
          end

          def self.generate_raw_data(slug: nil, publish_date: nil, published: true, title: nil, id: nil, excerpt: nil, seo: {})
            {
              id: id.presence || Faker::Number.number,
              attributes: generate_data(slug:, publish_date:, published:, title:, excerpt:, seo:)
            }
          end
        end
      end
    end
  end
end
