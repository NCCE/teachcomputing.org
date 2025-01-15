module Cms
  module Providers
    module Strapi
      module Factories
        module ComponentFactory
          def self.process_component(strapi_data)
            component_name = strapi_data[:__component]
            component_category, name = component_name.split(".", 2)

            case component_category
            when "blocks"
              BlocksFactory.generate_component(name, strapi_data)
            when "buttons"
              ButtonFactory.generate_component(name, strapi_data)
            when "content-blocks"
              ContentBlockFactory.generate_component(name, strapi_data)
            end
          end
        end
      end
    end
  end
end
