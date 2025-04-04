module Cms
  module Providers
    module Strapi
      module Mocks
        module Collections
          class EnrichmentCategory < StrapiMock # For terms and age groups
            attribute(:name) { Faker::Lorem.word }
          end
        end
      end
    end
  end
end
