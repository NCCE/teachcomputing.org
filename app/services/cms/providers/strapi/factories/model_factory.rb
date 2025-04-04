module Cms
  module Providers
    module Strapi
      module Factories
        module ModelFactory
          include BaseFactory

          MAPPING_FUNCTIONS = {
            Models::DynamicComponents::ContentBlocks::QuestionBankForm => :to_question_bank_forms,
            Models::Collections::Aside => :to_aside,
            Models::Collections::BlogPreview => :to_blog_preview,
            Models::DynamicZones::DynamicZone => :to_dynamic_zone,
            Models::Collections::EmailTemplate => :to_email_template,
            Models::DynamicZones::EnrichmentDynamicZone => :to_dynamic_zone,
            Models::Collections::EnrichmentList => :to_enrichment_list,
            Models::Images::FeaturedImage => :to_featured_image,
            Models::Meta::HeaderMenu => :to_menu,
            Models::DynamicZones::HomepageDynamicZone => :to_dynamic_zone,
            Models::Meta::PageTitle => :to_page_title,
            Models::Meta::Seo => :to_seo,
            Models::Meta::SimpleTitle => :to_simple_title,
            Models::Data::Slug => :to_slug,
            Models::Text::TextBlock => :to_text_block,
            Models::Text::TextBlockWithoutWrapper => :to_text_block_without_wrapper,
            Models::Data::TextField => :to_text_field,
            Models::Data::WebPagePreview => :to_web_page_preview
          }

          def self.process_model(mapping, all_data)
            model_class = mapping[:model]
            key = mapping[:key].presence
            is_array = mapping[:is_array].presence || false

            strapi_data = if key
              all_data[key]
            else
              all_data
            end

            model_function = MAPPING_FUNCTIONS[model_class]

            if is_array
              strapi_data.map { create_model(model_class, model_function, _1, all_data) }
            else
              create_model(model_class, model_function, strapi_data, all_data)
            end
          end

          def self.create_model(model_class, model_function, strapi_data, all_data)
            model_data = send(model_function, strapi_data, all_data)
            model_class.new(**model_data) if model_data
          end

          def self.to_aside(strapi_data, _all_data)
            {
              title: strapi_data[:title],
              title_icon: ModelFactory.to_image(strapi_data, :titleIcon),
              dynamic_content: Models::DynamicZones::DynamicZone.new(
                cms_models: strapi_data[:content].map { ComponentFactory.process_component(_1) }.compact
              ),
              show_heading_line: strapi_data[:showHeadingLine],
              aside_icons: BlocksFactory.to_icon_block(strapi_data[:asideIcons])
            }
          end

          def self.to_blog_preview(strapi_data, _all_data)
            {
              title: strapi_data[:title],
              excerpt: strapi_data[:excerpt],
              publish_date: strapi_data[:publishDate],
              featured_image: strapi_data[:featuredImage][:data].nil? ? nil : Models::Images::FeaturedImage.new(**to_featured_image(strapi_data[:featuredImage][:data][:attributes], nil, :small)),
              slug: strapi_data[:slug]
            }
          end

          def self.to_dynamic_zone(strapi_data, _all_data)
            {cms_models: strapi_data.map { ComponentFactory.process_component(_1) }.compact}
          end

          def self.to_email_template(strapi_data, _all_data)
            {
              slug: strapi_data[:slug],
              subject: strapi_data[:subject],
              programme_slug: strapi_data[:programme][:data][:attributes][:slug],
              email_content: strapi_data[:emailContent].map { ComponentFactory.process_component(_1) }.compact,
              completed_programme_activity_group_slugs: strapi_data.dig(:completedGroupings, :data).nil? ? nil : strapi_data[:completedGroupings][:data].collect { _1[:attributes][:slug] },
              activity_state: strapi_data[:activityState]
            }
          end

          def self.to_enrichment_list(strapi_data, all_data)
            {
              enrichments: strapi_data[:data].map { to_enrichment(_1[:attributes]) }.compact,
              featured_title: all_data[:featuredSectionTitle],
              all_title: all_data[:allSectionTitle],
              type_filter_placeholder: all_data[:typeFilterPlaceholder],
              age_group_filter_placeholder: all_data[:ageGroupFilterPlaceholder],
              term_filter_placeholder: all_data[:termFilterPlaceholder]
            }
          end

          def self.to_enrichment(strapi_data)
            return nil if strapi_data[:publishedAt].nil? && Rails.env.production?
            type_data = strapi_data[:type][:data][:attributes]
            Models::Collections::Enrichment.new(
              title: Models::Text::RichHeader.new(blocks: strapi_data[:rich_title]),
              details: strapi_data[:rich_details],
              link: strapi_data[:link],
              featured: strapi_data[:featured],
              i_belong: strapi_data[:i_belong],
              terms: strapi_data.dig(:terms, :data).map { _1[:attributes][:name] },
              age_groups: strapi_data.dig(:age_groups, :data).map { _1[:attributes][:name] },
              partner_icon: to_image(strapi_data, :partner_icon, default_size: :small),
              type: Models::Collections::EnrichmentType.new(
                name: type_data[:name],
                icon: to_image(type_data, :icon, default_size: :small)
              )
            )
          end

          def self.to_featured_image(strapi_data, _all_data, size = :large)
            return nil if strapi_data[:data]

            {
              url: strapi_data[:url],
              alt: strapi_data[:alternativeText],
              caption: strapi_data[:caption],
              formats: strapi_data[:formats],
              size:
            }
          end

          def self.to_menu(strapi_data, _all_data)
            {
              menu_items: strapi_data.map do |menu_item|
                {
                  label: menu_item[:label],
                  menu_items: menu_item[:menuItems].map { {label: _1[:label], url: _1[:url]} }
                }
              end
            }
          end

          def self.to_page_title(strapi_data, _all_data)
            {
              title: strapi_data[:title],
              sub_text: strapi_data[:subText],
              title_image: to_image(strapi_data, :titleImage),
              title_video_url: strapi_data[:titleVideoUrl],
              background_color: extract_color_name(strapi_data, :bkColor),
              i_belong_flag: strapi_data[:iBelongFlag]
            }
          end

          def self.to_question_bank_forms(strapi_data, _all_data)
            {
              form_name: strapi_data[:formName],
              links: strapi_data[:links].map { Models::DynamicComponents::ContentBlocks::Link.new(url: _1[:url], link_text: _1[:linkText]) }
            }
          end

          def self.to_seo(strapi_data, _all_data)
            {
              title: strapi_data[:title],
              description: strapi_data[:description],
              featured_image: to_image(strapi_data, :featuredImage)
            }
          end

          def self.to_simple_title(strapi_data, _all_data)
            {title: strapi_data}
          end

          def self.to_slug(strapi_data, _all_data)
            {slug: strapi_data[:slug]}
          end

          def self.to_text_block(strapi_data, _all_data)
            {blocks: process_block_data(strapi_data), with_wrapper: true}
          end

          def self.to_text_block_without_wrapper(strapi_data, _all_data)
            {blocks: process_block_data(strapi_data), with_wrapper: false}
          end

          def self.to_text_field(strapi_data, _all_data)
            {value: strapi_data}
          end

          def self.to_web_page_preview(strapi_data, _all_data)
            {
              title: strapi_data[:seo][:title],
              description: strapi_data[:seo][:description],
              slug: strapi_data[:slug]
            }
          end
        end
      end
    end
  end
end
