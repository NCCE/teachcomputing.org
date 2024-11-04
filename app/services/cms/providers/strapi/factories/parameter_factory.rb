module Cms
  module Providers
    module Strapi
      module Factories
        module ParameterFactory
          def self.generate_parameters(model_class)
            if model_class == Cms::Models::Seo
              {
                populate: {featuredImage: {populate: [:alternativeText]}},
                fields: [:title, :description]
              }
            elsif model_class == Cms::Models::FeaturedImage
              {populate: [:alternativeText, :caption]}
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
            elsif model_class == Models::DynamicZone
              {
                on: {
                  "blocks.text-with-asides": ComponentParameterFactory.text_with_asides_parameters,
                  "blocks.resource-card-section": ComponentParameterFactory.card_wrapper_parameters,
                  "blocks.picture-card-section": ComponentParameterFactory.card_wrapper_parameters,
                  "blocks.horizontal-card": ComponentParameterFactory.horizontal_card_parameters,
                  "blocks.question-and-answer": ComponentParameterFactory.question_and_answer_parameters,
                  "blocks.full-width-banner": ComponentParameterFactory.full_width_banner_parameters,
                  "blocks.full-width-text": ComponentParameterFactory.text_block_parameters
                }
              }
            end
          end
        end
      end
    end
  end
end
