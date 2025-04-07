module Cms
  module Providers
    module Strapi
      module Mocks
        module Collections
          class EnrichmentType < StrapiMock
            attribute(:name) { Faker::Lorem.word }
            attribute(:icon) { Images::Image.generate_raw_data }
          end
        end
      end
    end
  end
end
