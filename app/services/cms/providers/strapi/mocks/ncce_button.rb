module Cms
  module Providers
    module Strapi
      module Mocks
        class NcceButton < StrapiMock
          strapi_component "buttons.ncce-button"

          attribute(:title) { Faker::Lorem.word }
          attribute(:link) { Faker::Internet.url }
          attribute(:buttonTheme) { "green" }
          attribute(:loggedInTitle) { nil }
          attribute(:loggedInLink) { nil }
        end
      end
    end
  end
end
