module Cms
  module Providers
    module Strapi
      module Factories
        module ComponentFactory
          def self.process_component(strapi_data)
            if strapi_data[:__typename]
              component_name = strapi_data[:__typename]
                .underscore
                .tr("_", "-")
                .gsub(/\Acomponent-(blocks|content-blocks|buttons|email-content)-/, '\1.')
              return nil if strapi_data.keys.count == 1
            else
              component_name = strapi_data[:__component]
            end
            component_category, name = component_name.split(".", 2)

            case component_category
            when "blocks"
              BlocksFactory.generate_component(name, strapi_data)
            when "buttons"
              ButtonFactory.generate_component(name, strapi_data)
            when "content-blocks"
              ContentBlockFactory.generate_component(name, strapi_data)
            when "email-content"
              EmailComponentFactory.generate_component(name, strapi_data)
            end
          end
        end
      end
    end
  end
end
