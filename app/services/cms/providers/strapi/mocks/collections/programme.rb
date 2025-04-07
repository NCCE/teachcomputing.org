module Cms
  module Providers
    module Strapi
      module Mocks
        module Collections
          class Programme < StrapiMock
            attribute(:slug) { Faker::Internet.slug }
            attribute(:statusPendingTitle) { Faker::Internet.slug }
            attribute(:statusPendingText) { Text::RichBlocks.generate_data }
            attribute(:statusCompletedTitle) { Faker::Internet.slug }
            attribute(:statusCompletedText) { Text::RichBlocks.generate_data }
          end
        end
      end
    end
  end
end
