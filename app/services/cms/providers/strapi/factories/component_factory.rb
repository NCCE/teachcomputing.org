module Cms
  module Providers
    module Strapi
      module Factories
        module ComponentFactory
          def self.process_component(strapi_data)
            component_name = strapi_data[:__component]
            case component_name
            when "content-blocks.text-block"
              Cms::Models::ContentBlock.new(blocks: strapi_data[:content])
            when "content-blocks.file-link"
              file_data = strapi_data.dig(:file, :data) ? strapi_data[:file][:data][:attributes] : nil
              ModelFactory.to_file(file_data) if file_data
            end
          end
        end
      end
    end
  end
end
