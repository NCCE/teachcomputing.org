module Cms
  module Providers
    module Strapi
      module Factories
        module ModelFactory
          def self.process_model(mapping, all_data)
            model_class = mapping[:model]
            key = mapping[:key].presence
            strapi_data = if key
              all_data[key]
            else
              all_data
            end

            if model_class == Models::Seo
              model_class.new(
                title: strapi_data[:title],
                description: strapi_data[:description],
                featured_image: strapi_data.dig(:featuredImage, :data) ? to_image(strapi_data[:featuredImage][:data][:attributes]) : nil
              )
            elsif model_class == Models::FeaturedImage
              to_featured_image(strapi_data[:data][:attributes]) if strapi_data[:data]
            elsif model_class == Models::ContentBlock
              to_content_block(strapi_data)
            elsif model_class == Models::RichHeader
              model_class.new(blocks: strapi_data)
            elsif model_class == Models::SimpleTitle
              model_class.new(title: strapi_data)
            elsif model_class == Models::Aside
              model_class.new(
                title: strapi_data[:title],
                dynamic_content: Models::DynamicZone.new(strapi_data[:content].map { ComponentFactory.process_component(_1) }.compact),
                show_heading_line: strapi_data[:showHeadingLine]
              )
            elsif model_class == Models::PageTitle
              model_class.new(
                title: strapi_data[:title],
                intro_text: strapi_data[:introText]
              )
            elsif model_class == Models::BlogPreview
              model_class.new(
                title: strapi_data[:title],
                excerpt: strapi_data[:excerpt],
                publish_date: strapi_data[:publishDate],
                featured_image: strapi_data[:featuredImage][:data].nil? ? nil : to_featured_image(strapi_data[:featuredImage][:data][:attributes], :small),
                slug: strapi_data[:slug]
              )
            elsif model_class == Models::DynamicZone
              model_class.new(strapi_data.map { ComponentFactory.process_component(_1) }.compact)
            elsif model_class == Models::EnrichmentList
              model_class.new(
                enrichments: strapi_data[:data].map { to_enrichment(_1[:attributes]) }.compact,
                featured_title: all_data[:featuredSectionTitle],
                all_title: all_data[:allSectionTitle],
                type_filter_placeholder: all_data[:typeFilterPlaceholder],
                age_group_filter_placeholder: all_data[:ageGroupFilterPlaceholder],
                term_filter_placeholder: all_data[:termFilterPlaceholder]
              )
            elsif model_class == Models::SimplePagePreview
              model_class.new(
                title: strapi_data[:title],
                slug: strapi_data[:slug],
                excerpt: strapi_data[:seo][:description]
              )
            end
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
              partner_icon: strapi_data[:partner_icon][:data].nil? ? nil : to_image(strapi_data[:partner_icon][:data][:attributes]),
              type: Models::EnrichmentType.new(
                name: type_data[:name],
                icon: type_data[:icon][:data].nil? ? nil : to_image(type_data[:icon][:data][:attributes])
              )
            )
          end

          def self.to_content_block(data, with_wrapper: true)
            data.map! do |block|
              block[:image] = to_image(block[:image]) if block[:type] == "image"
              block
            end
            Models::ContentBlock.new(blocks: data, with_wrapper:)
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

          def self.to_image(image_data, default_size: :medium)
            Models::Image.new(
              url: image_data[:url],
              alt: image_data[:alternativeText],
              caption: image_data[:caption],
              formats: image_data[:formats],
              default_size:
            )
          end
        end
      end
    end
  end
end
