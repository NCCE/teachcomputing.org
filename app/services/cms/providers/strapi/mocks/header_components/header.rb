module Cms
  module Providers
    module Strapi
      module Mocks
        module HeaderComponents
          class Header < StrapiMock
            attribute(:dropDowns) { Array.new(3) { DropDownMenu.generate_raw_data } }
          end

          class DropDownMenu < StrapiMock
            strapi_component "content-blocks.drop-down-menu"
            attribute(:label) { Faker::Lorem.word }
            attribute(:menuItems) { Array.new(5) { MenuItem.generate_raw_data } }
          end

          class MenuItem < StrapiMock
            strapi_component "content-blocks.menu-item"
            attribute(:label) { Faker::Lorem.word }
            attribute(:url) { "/primary-certificate" }
          end
        end
      end
    end
  end
end
