module Cms
  module Providers
    module Strapi
      module Mocks
        class PageTitle < StrapiMock
          attribute(:title) { Faker::Lorem.words(number: 5) }
          attribute(:subText) { nil }
        end
      end
    end
  end
end
