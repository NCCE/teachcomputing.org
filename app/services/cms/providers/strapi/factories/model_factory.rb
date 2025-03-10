module Cms
  module Providers
    module Strapi
      module Factories
        module ModelFactory
          include BaseFactory

          def self.process_model(mapping, all_data)
            model_class = mapping[:model]
            key = mapping[:key].presence
            strapi_data = if key
              all_data[key]
            else
              all_data
            end
            if model_class == Models::Seo
              to_seo(strapi_data)
            elsif model_class == Models::Slug
              model_class.new(slug: strapi_data[:slug])
            elsif model_class == Models::TextField
              model_class.new(value: strapi_data)
            elsif model_class == Models::FeaturedImage
              to_featured_image(strapi_data[:data][:attributes]) if strapi_data[:data]
            elsif model_class == Models::TextBlock
              with_wrapper = if mapping.key?(:with_wrapper)
                mapping[:with_wrapper]
              else
                true
              end
              to_content_block(strapi_data, with_wrapper:)
            elsif model_class == Models::SimpleTitle
              model_class.new(title: strapi_data)
            elsif model_class == Models::Aside
              model_class.new(
                title: strapi_data[:title],
                title_icon: ModelFactory.to_image(strapi_data, :titleIcon),
                dynamic_content: Models::DynamicZone.new(
                  cms_models: strapi_data[:content].map { ComponentFactory.process_component(_1) }.compact
                ),
                show_heading_line: strapi_data[:showHeadingLine],
                aside_icons: BlocksFactory.to_icon_block(strapi_data[:asideIcons])
              )
            elsif model_class == Models::PageTitle
              model_class.new(
                title: strapi_data[:title],
                sub_text: strapi_data[:subText],
                title_image: to_image(strapi_data, :titleImage),
                title_video_url: strapi_data[:titleVideoUrl],
                background_color: extract_color_name(strapi_data, :bkColor),
                i_belong_flag: strapi_data[:iBelongFlag]
              )
            elsif model_class == Models::BlogPreview
              to_blog_preview(strapi_data)
            elsif model_class == Models::WebPagePreview
              to_web_page_preview(strapi_data)
            elsif model_class == Models::DynamicZone
              model_class.new(cms_models: strapi_data.map { ComponentFactory.process_component(_1) }.compact)
            elsif model_class == Models::EnrichmentDynamicZone
              model_class.new(cms_models: strapi_data.map { ComponentFactory.process_component(_1) }.compact)
            elsif model_class == Models::EnrichmentList
              to_enrichment_list(all_data, strapi_data)
            elsif model_class == Models::HeaderMenu
              to_menu(strapi_data)
            elsif model_class == Models::EmailTemplate
              to_email_template(strapi_data)
            end
          end

          def self.to_email_template(strapi_data)
            Models::EmailTemplate.new(
              slug: strapi_data[:slug],
              subject: strapi_data[:subject],
              programme_slug: strapi_data[:programme][:data][:attributes][:slug],
              email_content: strapi_data[:emailContent].map { ComponentFactory.process_component(_1) }.compact,
              completed_programme_activity_group_slugs: strapi_data.dig(:completedGroupings, :data).nil? ? nil : strapi_data[:completedGroupings][:data].collect { _1[:attributes][:slug] },
              activity_state: strapi_data[:activityState]
            )
          end

          def self.to_menu(strapi_data)
            Models::HeaderMenu.new(
              strapi_data.map do |menu_item|
                {
                  label: menu_item[:label],
                  menu_items: menu_item[:menuItems].map { {label: _1[:label], url: _1[:url]} }
                }
              end
            )
          end

          def self.to_seo(strapi_data)
            Models::Seo.new(
              title: strapi_data[:title],
              description: strapi_data[:description],
              featured_image: to_image(strapi_data, :featuredImage)
            )
          end

          def self.to_blog_preview(strapi_data)
            Models::BlogPreview.new(
              title: strapi_data[:title],
              excerpt: strapi_data[:excerpt],
              publish_date: strapi_data[:publishDate],
              featured_image: strapi_data[:featuredImage][:data].nil? ? nil : to_featured_image(strapi_data[:featuredImage][:data][:attributes], :small),
              slug: strapi_data[:slug]
            )
          end

          def self.to_web_page_preview(strapi_data)
            Models::WebPagePreview.new(
              title: strapi_data[:seo][:title],
              description: strapi_data[:seo][:description],
              slug: strapi_data[:slug]
            )
          end

          def self.to_enrichment_list(all_data, strapi_data)
            Models::EnrichmentList.new(
              enrichments: strapi_data[:data].map { to_enrichment(_1[:attributes]) }.compact,
              featured_title: all_data[:featuredSectionTitle],
              all_title: all_data[:allSectionTitle],
              type_filter_placeholder: all_data[:typeFilterPlaceholder],
              age_group_filter_placeholder: all_data[:ageGroupFilterPlaceholder],
              term_filter_placeholder: all_data[:termFilterPlaceholder]
            )
          end

          def self.to_enrichment(strapi_data)
            return nil if strapi_data[:publishedAt].nil? && Rails.env.production?
            type_data = strapi_data[:type][:data][:attributes]
            Models::Enrichment.new(
              title: Models::RichHeader.new(blocks: strapi_data[:rich_title]),
              details: strapi_data[:rich_details],
              link: strapi_data[:link],
              featured: strapi_data[:featured],
              i_belong: strapi_data[:i_belong],
              terms: strapi_data.dig(:terms, :data).map { _1[:attributes][:name] },
              age_groups: strapi_data.dig(:age_groups, :data).map { _1[:attributes][:name] },
              partner_icon: to_image(strapi_data, :partner_icon, default_size: :small),
              type: Models::EnrichmentType.new(
                name: type_data[:name],
                icon: to_image(type_data, :icon, default_size: :small)
              )
            )
          end

          def self.to_featured_image(image_data, size = :large)
            Models::FeaturedImage.new(
              url: image_data[:url],
              alt: image_data[:alternativeText],
              caption: image_data[:caption],
              formats: image_data[:formats],
              size:
            )
          end
        end
      end
    end
  end
end
