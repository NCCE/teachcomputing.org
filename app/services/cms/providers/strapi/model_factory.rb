module Cms
  module Providers
    module Strapi
      module ModelFactory
        def self.process_model(model_class, strapi_data)
          if model_class == Cms::Models::Seo
            model_class.new(
              strapi_data[:title],
              strapi_data[:description]
            )
          elsif model_class == Cms::Models::FeaturedImage
            to_featured_image(strapi_data[:data][:attributes])
          elsif model_class == Cms::Models::ContentBlock
            to_content_block(strapi_data)
          elsif model_class == Cms::Models::SimpleTitle
            model_class.new(strapi_data)
          elsif model_class == Cms::Models::BlogPreview
            model_class.new(
              strapi_data[:title],
              strapi_data[:excerpt],
              strapi_data[:publishedAt],
              strapi_data[:featuredImage][:data].nil? ? nil : to_featured_image(strapi_data[:featuredImage][:data][:attributes]),
              strapi_data[:slug]
            )
          end
        end

        def self.to_content_block(data)
          data.map! do |block|
            block[:image] = to_image(block[:image]) if block[:type] == "image"
            block
          end
          Cms::Models::ContentBlock.new(data)
        end

        def self.to_featured_image(image_data)
          Cms::Models::FeaturedImage.new(
            image_data[:url],
            image_data[:alternativeText],
            image_data[:caption],
            image_data[:formats]
          )
        end

        def self.to_image(image_data)
          Cms::Models::Image.new(
            image_data[:url],
            image_data[:alternativeText],
            image_data[:caption],
            image_data[:formats]
          )
        end
      end
    end
  end
end
