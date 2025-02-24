module Cms
  module Providers
    module Strapi
      module Mocks
        class EnrichmentType < StrapiMock
          attribute(:name) { Faker::Lorem.word }
          attribute(:icon) { Mocks::Image.generate_raw_data }
        end
      end
    end
  end
end
