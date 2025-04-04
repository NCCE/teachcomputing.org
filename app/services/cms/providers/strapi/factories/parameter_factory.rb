module Cms
  module Providers
    module Strapi
      module Factories
        module ParameterFactory
          def self.generate_parameters(model_class)
            if model_class == Cms::Models::Meta::Seo
              {
                populate: {featuredImage: {populate: [:alternativeText]}},
                fields: [:title, :description]
              }
            elsif model_class == Models::Images::FeaturedImage
              {populate: [:alternativeText, :caption]}
            elsif model_class == Models::Collections::EnrichmentList
              {
                populate: {
                  partner_icon: {populate: [:alternativeText]},
                  terms: {populate: [:name]},
                  age_groups: {populate: [:name]},
                  type: {populate: {icon: {populate: [:alternativeText]}}}
                }
              }
            elsif model_class == Models::Collections::BlogPreview
              {
                populate: {featuredImage: {populate: [:alternativeText]}},
                fields: [:title, :excerpt, :publishDate, :slug, :publishedAt, :createdAt, :updatedAt],
                sort: ["publishDate:desc"],
                filters: {
                  publishDate: {"$lt": DateTime.now.strftime}
                }
              }
            elsif model_class == Models::Collections::EmailTemplate
              {
                programme: {field: [:slug]},
                emailContent: {
                  on: {
                    "email-content.text": {populate: {fields: [:textContent]}},
                    "email-content.cta": {populate: {fields: [:link, :text]}},
                    "email-content.course-list": {populate: {
                      fields: [:sectionTitle],
                      courses: {populate: {fields: [:activityCode, :displayName, :substitute]}}
                    }}
                  }
                }
              }
            elsif model_class == Models::Data::WebPagePreview
              {
                populate: {seo: {fields: [:title, :description]}},
                fields: [:slug, :publishedAt, :createdAt, :updatedAt]
              }
            elsif model_class == Models::Meta::PageTitle
              {
                fields: [:title],
                populate: {titleImage: {populate: [:alternativeText]}}
              }
            elsif model_class == Models::Collections::Aside
              {
                fields: [:slug, :title, :showHeadingLine],
                titleIcon: {populate: [:alternativeText]},
                asideIcons: {
                  populate: {iconImage: {populate: [:alternativeText]}}
                },
                content: {
                  on: {
                    "content-blocks.text-block": ComponentParameterFactory.content_block_text_block,
                    "content-blocks.file-link": ComponentParameterFactory.content_block_file_link,
                    "content-blocks.linked-picture": ComponentParameterFactory.content_block_linked_picture,
                    "content-blocks.enrol-button": ComponentParameterFactory.content_block_enrol_button,
                    "content-blocks.link-with-icon": ComponentParameterFactory.content_block_link_with_icon
                  }
                }
              }
            elsif model_class == Models::DynamicZones::DynamicZone
              {
                on: {
                  "blocks.text-with-asides": ComponentParameterFactory.text_with_asides_parameters,
                  "blocks.resource-card-section": ComponentParameterFactory.card_wrapper_parameters,
                  "blocks.picture-card-section": ComponentParameterFactory.card_wrapper_parameters,
                  "blocks.numeric-cards-section": ComponentParameterFactory.card_wrapper_parameters,
                  "blocks.horizontal-card": ComponentParameterFactory.horizontal_card_parameters,
                  "blocks.question-and-answer": ComponentParameterFactory.question_and_answer_parameters,
                  "blocks.full-width-banner": ComponentParameterFactory.full_width_banner_parameters,
                  "blocks.full-width-text": ComponentParameterFactory.text_block_parameters,
                  "blocks.testimonial-row": ComponentParameterFactory.testimonial_row_parameters,
                  "blocks.numbered-icon-list": ComponentParameterFactory.numbered_icon_list_parameters,
                  "blocks.split-horizontal-card": ComponentParameterFactory.split_horizontal_card_parameters,
                  "blocks.community-activity-list": ComponentParameterFactory.community_activity_list_parameters,
                  "blocks.sticky-dashboard-bar": ComponentParameterFactory.sticky_dashboard_bar_parameters,
                  "blocks.enrolment-testimonial": ComponentParameterFactory.enrolment_testimonial_parameters,
                  "blocks.enrolment-split-course-card": ComponentParameterFactory.enrolment_split_course_card_parameters
                }
              }
            end
          end
        end
      end
    end
  end
end
