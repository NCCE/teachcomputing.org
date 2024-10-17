module Cms
  module Providers
    module Strapi
      module Mocks
        class NcceButton < StrapiMock
          strapi_component "buttons.ncce-button"

          attribute(:title) { Faker::Lorem.word }
          attribute(:link) { Faker::Internet.url }
        end
      end
    end
  end
end
