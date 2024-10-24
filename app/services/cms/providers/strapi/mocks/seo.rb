module Cms
  module Providers
    module Strapi
      module Mocks
        class Seo < StrapiMock
          attribute(:title) { Faker::Lorem.sentence }
          attribute(:description) { Faker::Lorem.paragraphs(number: 2).join(" ") }
          attribute(:featured_image) { nil }
        end
      end
    end
  end
end
