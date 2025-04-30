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

            def extract_programme_slug(strapi_data, key)
              strapi_data[key][:data][:attributes][:slug] if strapi_data.dig(key, :data)
            end

            def as_image(image_data, default_size = :medium)
              Models::Images::Image.new(
                url: image_data[:url],
                alt: image_data[:alternativeText],
                caption: image_data[:caption],
                formats: image_data[:formats],
                default_size:
              )
            end

            def process_block_data(blocks)
              return nil if blocks.nil?

              blocks.map! do |block|
                block[:image] = as_image(block[:image], :medium) if block[:type] == "image"
                block
              end
            end

            def to_content_block(data, with_wrapper: false, **)
              return nil if data.nil?

              Models::Text::TextBlock.new(blocks: process_block_data(data), with_wrapper:, **)
            end

            def to_image(strapi_data, image_key, default_size: :medium)
              if strapi_data.dig(image_key, :data)
                image_data = strapi_data[image_key][:data][:attributes]
                as_image(image_data, default_size)
              end
            end

            def to_testimonial(strapi_data)
              Models::DynamicComponents::ContentBlocks::Testimonial.new(
                name: strapi_data[:name],
                job_title: strapi_data[:jobTitle],
                avatar: to_image(strapi_data, :avatar, default_size: :small),
                quote: to_content_block(strapi_data[:quote])
              )
            end

            def to_ncce_button(strapi_data)
              return nil if strapi_data.nil?

              Models::DynamicComponents::Buttons::NcceButton.new(
                title: strapi_data[:title],
                link: strapi_data[:link],
                color: strapi_data[:buttonTheme],
                logged_in_title: strapi_data[:loggedInTitle],
                logged_in_link: strapi_data[:loggedInLink]
              )
            end

            def to_enrol_button(strapi_data, programme = nil)
              return nil if strapi_data[:loggedOutButtonText].blank? && strapi_data[:loggedInButtonText].blank?

              unless programme
                slug = strapi_data.dig(:programme, :data, :attributes, :slug)
                return nil if slug.nil?

                programme = Programme.find_by(slug:)
              end

              Models::DynamicComponents::Buttons::EnrolButton.new(
                logged_out_button_text: strapi_data[:loggedOutButtonText],
                logged_in_button_text: strapi_data[:loggedInButtonText],
                programme:
              )
            end

            def to_icon(icon_data)
              Models::DynamicComponents::ContentBlocks::Icon.new(
                text: icon_data[:iconText],
                image: to_image(icon_data, :iconImage, default_size: :small)
              )
            end

            def to_file(data)
              Models::DynamicComponents::ContentBlocks::FileLink.new(
                url: data[:url],
                filename: data[:name],
                size: data[:size],
                updated_at: DateTime.parse(data[:updatedAt])
              )
            end

            def to_embedded_video(strapi_data)
              Models::DynamicComponents::ContentBlocks::EmbeddedVideo.new(
                url: strapi_data[:url]
              )
            end

            def to_multi_state_link(strapi_data, programme)
              Models::Meta::MultiStateLink.new(
                programme:,
                logged_out_link_title: strapi_data[:loggedOutLinkTitle],
                logged_out_link: strapi_data[:loggedOutLink],
                not_enrolled_link_title: strapi_data[:notEnrolledLinkTitle],
                not_enrolled_link: strapi_data[:notEnrolledLink],
                enrolled_link_title: strapi_data[:enrolledLinkTitle],
                enrolled_link: strapi_data[:enrolledLink]
              )
            end
          end
        end
      end
    end
  end
end
