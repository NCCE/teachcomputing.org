module Cms
  module Providers
    module Strapi
      module Factories
        module BaseFactory
          def self.included(base)
            base.extend(ClassMethods)
          end

          module ClassMethods
            def extract_aside_sections(strapi_data, param_name: :asideSections)
              if strapi_data.dig(param_name, :data)
                Array.wrap(strapi_data[param_name][:data]).collect { _1[:attributes] }
              else
                []
              end
            end

            def extract_color_name(strapi_data, key)
              strapi_data[key][:data][:attributes][:name] if strapi_data.dig(key, :data)
            end

            def as_image(image_data, default_size = :medium)
              Models::Image.new(
                url: image_data[:url],
                alt: image_data[:alternativeText],
                caption: image_data[:caption],
                formats: image_data[:formats],
                default_size:
              )
            end

            def to_content_block(data, with_wrapper: false, **)
              data.map! do |block|
                block[:image] = as_image(block[:image], :medium) if block[:type] == "image"
                block
              end
              Models::TextBlock.new(blocks: data, with_wrapper:, **)
            end

            def to_image(strapi_data, image_key, default_size: :medium)
              if strapi_data.dig(image_key, :data)
                image_data = strapi_data[image_key][:data][:attributes]
                as_image(image_data, default_size)
              end
            end

            def to_testimonial(strapi_data)
              DynamicComponents::Testimonial.new(
                name: strapi_data[:name],
                job_title: strapi_data[:jobTitle],
                avatar: to_image(strapi_data, :avatar, default_size: :small),
                quote: to_content_block(strapi_data[:quote])
              )
            end

            def to_ncce_button(strapi_data)
              DynamicComponents::NcceButton.new(title: strapi_data[:title], link: strapi_data[:link], color: strapi_data[:buttonTheme])
            end

            def to_icon(icon_data)
              DynamicComponents::Icon.new(
                text: icon_data[:iconText],
                image: to_image(icon_data, :iconImage, default_size: :small)
              )
            end

            def to_file(data)
              DynamicComponents::FileLink.new(
                url: data[:url],
                filename: data[:name],
                size: data[:size],
                updated_at: DateTime.parse(data[:updatedAt])
              )
            end
          end
        end
      end
    end
  end
end
