module Cms
  module Providers
    module Strapi
      module Mocks
        class IconRow < StrapiMock
          strapi_component "blocks.icon-row"

          attribute(:icons) { Array.new(2) { Icon.generate_data } }
        end
      end
    end
  end
end
