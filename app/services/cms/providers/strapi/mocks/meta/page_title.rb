module Cms
  module Providers
    module Strapi
      module Mocks
        module Meta
          class PageTitle < StrapiMock
            attribute(:title) { Faker::Lorem.words(number: 5) }
            attribute(:subText) { nil }
            attribute(:titleImage) { nil }
            attribute(:titleVideoUrl) { nil }
            attribute(:bkColor) { nil }
            attribute(:iBelongFlag) { false }
          end
        end
      end
    end
  end
end
