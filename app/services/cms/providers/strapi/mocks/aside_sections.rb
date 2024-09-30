module Cms
  module Providers
    module Strapi
      module Mocks
        class AsideSections
          def self.generate_data(slugs: [])
            slugs.map do |slug|
              {
                id: Faker::Number.number,
                slug:
              }
            end
          end

          def self.generate_raw_data(slugs: [])
            {
              data: generate_data(slugs:).map { {attributes: _1} }
            }
          end
        end
      end
    end
  end
end
