module Cms
  module Providers
    module Strapi
      module Mocks
        class BlogTag < StrapiMock
          attribute(:title) { Faker::Lorem.word }
          attribute(:slug) { Faker::Internet.slug }
          attribute(:description) { Faker::Lorem.paragraph }
        end
      end
    end
  end
end