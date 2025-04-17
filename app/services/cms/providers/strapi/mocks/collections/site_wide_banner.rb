module Cms
  module Providers
    module Strapi
      module Mocks
        module Collections
          class SiteWideBanner < StrapiMock
            attribute(:textContent) { Text::RichBlocks.generate_data }
            attribute(:startTime) { Faker::Time.backward(days: 2) }
            attribute(:endTime) { Faker::Time.forward(days: 2) }
          end
        end
      end
    end
  end
end
