module Cms
  module Providers
    module Strapi
      module Factories
        module ContentBlockFactory
          include BaseFactory

          def self.generate_component(component_name, strapi_data)
            case component_name
            when "text-block"
              to_content_block(strapi_data[:textContent])
            when "file-link"
              file_data = strapi_data.dig(:file, :data) ? strapi_data[:file][:data][:attributes] : nil
              to_file(file_data) if file_data
            when "linked-picture"
              to_linked_picture(strapi_data)
            when "testimonial"
              to_testimonial(strapi_data)
            when "enrol-button"
              to_enrol_button(strapi_data)
            when "link-with-icon"
              to_link_with_icon(strapi_data)
            end
          end

          def self.to_linked_picture(strapi_data)
            DynamicComponents::LinkedPicture.new(
              image: to_image(strapi_data, :image),
              link: strapi_data[:link]
            )
          end

          def self.to_enrol_button(strapi_data)
            DynamicComponents::EnrolButton.new(
              button_text: strapi_data[:buttonText],
              programme_slug: strapi_data[:programme][:data][:attributes][:slug]
            )
          end

          def self.to_link_with_icon(strapi_data)
            DynamicComponents::LinkWithIcon.new(
              url: strapi_data[:url],
              link_text: strapi_data[:linkText],
              icon: ModelFactory.to_image(strapi_data, :icon, default_size: :small)
            )
          end
        end
      end
    end
  end
end
