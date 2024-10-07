module Cms
  module Providers
    module Strapi
      module Mocks
        class ColourScheme
          def self.generate_data(name: "standard")
            {
              id: 1,
              data: {
                attributes: generate_raw_data(name: name)
              }
            }
          end

          def self.generate_raw_data(name: "standard")
            {
              name: name,
              publicName: "TC Green"
            }
          end
        end
      end
    end
  end
end
