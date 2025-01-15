module Cms
  module Providers
    module Strapi
      module Factories
        module ButtonFactory
          include BaseFactory

          def self.generate_component(component_name, strapi_data)
            case component_name
            when "ncce-button"
              to_ncce_button(strapi_data)
            end
          end
        end
      end
    end
  end
end
