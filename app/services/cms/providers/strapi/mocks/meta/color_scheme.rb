module Cms
  module Providers
    module Strapi
      module Mocks
        module Meta
          class ColorScheme
            def self.generate_data(name: "standard")
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
end
