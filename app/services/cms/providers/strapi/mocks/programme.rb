module Cms
  module Providers
    module Strapi
      module Mocks
        class Programme < StrapiMock
          attribute(:slug) { Faker::Internet.slug }
          attribute(:statusPendingTitle) { Faker::Internet.slug }
          attribute(:statusPendingText) { TextBlock.generate_raw_data }
          attribute(:statusCompletedTitle) { Faker::Internet.slug }
          attribute(:statusCompletedText) { TextBlock.generate_raw_data }
        end
      end
    end
  end
end
