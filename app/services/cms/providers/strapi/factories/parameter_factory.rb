module Cms
  module Providers
    module Strapi
      module Factories
        module ParameterFactory
          def self.generate_parameters(model_class)
            if model_class == Cms::Models::Seo
              {populate: {featuredImage: {populate: [:alternativeText]}}}
            elsif model_class == Cms::Models::FeaturedImage
              {populate: [:alternativeText, :caption]}
            elsif model_class == Cms::Models::SimplePagePreview
              {
                populate: {seo: {populate: [:description]}},
                fields: [:title, :slug, :publishedAt, :createdAt, :updatedAt]
              }
            elsif model_class == Cms::Models::EnrichmentList
              {
                populate: {
                  partner_icon: {populate: [:alternativeText]},
                  terms: {populate: [:name]},
                  age_groups: {populate: [:name]},
                  type: {populate: {icon: {populate: [:alternativeText]}}}
                }
              }
            elsif model_class == Cms::Models::BlogPreview
              {
                populate: {featuredImage: {populate: [:alternativeText]}},
                fields: [:title, :excerpt, :publishDate, :slug, :publishedAt, :createdAt, :updatedAt],
                sort: ["publishDate:desc"],
                filters: {
                  publishDate: {"$lt": DateTime.now.strftime}
                }
              }
            elsif model_class == Models::PageTitle
              {
                populate: [:title]
              }
            end
          end
        end
      end
    end
  end
end
