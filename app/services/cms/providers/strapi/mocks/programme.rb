module Cms
  module Providers
    module Strapi
      module Mocks
        class Programme < StrapiMock
          attribute(:slug) { Faker::Internet.slug }
          attribute(:statusPendingTitle) { Faker::Internet.slug }
          attribute(:statusPendingText) { RichBlocks.generate_data }
          attribute(:statusCompletedTitle) { Faker::Internet.slug }
          attribute(:statusCompletedText) { RichBlocks.generate_data }
        end
      end
    end
  end
end
