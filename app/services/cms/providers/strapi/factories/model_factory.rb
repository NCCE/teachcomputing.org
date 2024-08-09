module Cms
  module Providers
    module Strapi
      module Factories
        module ModelFactory
          def self.process_model(model_class, strapi_data)
            if model_class == Cms::Models::Seo
              model_class.new(
                title: strapi_data[:title],
                description: strapi_data[:description],
                featured_image: strapi_data.dig(:featuredImage, :data) ? to_image(strapi_data[:featuredImage][:data][:attributes]) : nil
              )
            elsif model_class == Cms::Models::FeaturedImage
              to_featured_image(strapi_data[:data][:attributes])
            elsif model_class == Cms::Models::ContentBlock
              to_content_block(strapi_data)
            elsif model_class == Cms::Models::SimpleTitle
              model_class.new(title: strapi_data)
            elsif model_class == Models::Aside
              model_class.new(
                title: strapi_data[:title],
                content: strapi_data[:content],
                files: strapi_data.dig(:files, :data) ? strapi_data[:files][:data]&.map { to_file(_1[:attributes]) } : nil
              )
            elsif model_class == Cms::Models::BlogPreview
              model_class.new(
                title: strapi_data[:title],
                excerpt: strapi_data[:excerpt],
                publish_date: strapi_data[:publishDate],
                featured_image: strapi_data[:featuredImage][:data].nil? ? nil : to_featured_image(strapi_data[:featuredImage][:data][:attributes], :small),
                slug: strapi_data[:slug]
              )
            elsif model_class == Cms::Models::SimplePagePreview
              model_class.new(
                title: strapi_data[:title],
                slug: strapi_data[:slug],
                excerpt: strapi_data[:seo][:description]
              )
            end
          end

          def self.to_file(data)
            Models::File.new(
              url: data[:url],
              filename: data[:name],
              size: data[:size],
              updated_at: DateTime.parse(data[:updatedAt])
            )
          end

          def self.to_content_block(data)
            data.map! do |block|
              block[:image] = to_image(block[:image]) if block[:type] == "image"
              block
            end
            Cms::Models::ContentBlock.new(blocks: data)
          end

          def self.to_featured_image(image_data, size = :large)
            Cms::Models::FeaturedImage.new(
              url: image_data[:url],
              alt: image_data[:alternativeText],
              caption: image_data[:caption],
              formats: image_data[:formats],
              size:
            )
          end

          def self.to_image(image_data)
            Cms::Models::Image.new(
              url: image_data[:url],
              alt: image_data[:alternativeText],
              caption: image_data[:caption],
              formats: image_data[:formats],
              default_size: :medium
            )
          end
        end
      end
    end
  end
end
