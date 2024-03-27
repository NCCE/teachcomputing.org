module Cms
  module Providers
    module Strapi
      module Factories
        module ParameterFactory
          def self.generate_parameters(model_class)
            if model_class == Cms::Models::Seo
              {populate: [:title, :description]}
            elsif model_class == Cms::Models::FeaturedImage
              {populate: [:alternativeText, :caption]}
            elsif model_class == Cms::Models::BlogPreview
              {
                populate: {featuredImage: {populate: [:alternativeText]}},
                fields: [:title, :excerpt, :publishDate, :slug, :publishedAt, :createdAt, :updatedAt],
                sort: ["publishDate:desc"]
              }
            end
          end
        end
      end
    end
  end
end
