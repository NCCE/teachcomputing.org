module Cms
  module Providers
    module Strapi
      module Mocks
        class EmailTemplate < StrapiMock
          attribute(:subject) { Faker::Lorem.sentence }
          attribute(:slug) { Faker::Internet.slug }
          attribute(:emailContent) { [] }
          attribute(:programme) {
            {data: {attributes: {slug: "primary-certificate"}}}
          }
        end
      end
    end
  end
end
