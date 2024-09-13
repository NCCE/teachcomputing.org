module Cms
  module Providers
    module Strapi
      module Factories
        module ComponentFactory
          def self.process_component(strapi_data)
            component_name = strapi_data[:__component]
            case component_name
            when "content-blocks.text-block"
              Models::ContentBlock.new(blocks: strapi_data[:textContent], with_wrapper: false)
            when "content-blocks.file-link"
              file_data = strapi_data.dig(:file, :data) ? strapi_data[:file][:data][:attributes] : nil
              ModelFactory.to_file(file_data) if file_data
            when "blocks.text-with-asides"
              asides = if strapi_data.dig(:asideSections, :data)
                strapi_data[:asideSections][:data].collect { _1[:attributes] }
              else
                []
              end
              DynamicComponents::TextWithAsides.new(blocks: strapi_data[:textContent], asides:)
            when "blocks.horizontal-card"
              DynamicComponents::HorizontalCard.new(
                title: strapi_data[:title],
                body_blocks: strapi_data[:bodyText],
                image: strapi_data.dig(:image, :data) ? ModelFactory.to_image(strapi_data[:image][:data][:attributes]) : nil,
                image_link: strapi_data[:imageLink],
                colour_theme: strapi_data.dig(:colourTheme, :data) ? strapi_data[:colourTheme][:data][:attributes][:name] : nil,
                icon_block: strapi_data[:iconBlock].map do |block|
                  {
                    text: block[:iconText],
                    image: ModelFactory.to_image(block[:iconImage][:data][:attributes])
                  }
                end
              )
            end
          end
        end
      end
    end
  end
end
