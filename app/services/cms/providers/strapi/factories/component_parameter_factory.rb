module Cms
  module Providers
    module Strapi
      module Factories
        module ComponentParameterFactory
          def self.text_with_asides_parameters
            {
              populate: {
                fields: ["textContent"],
                asideSections: populate_fields("name"),
                bkColor: populate_fields("name")
              }
            }
          end

          def self.horizontal_card_parameters
            {
              populate: {
                iconBlock: icon_block_parameters,
                colorTheme: populate_fields("name"),
                image: image_params
              }
            }
          end

          def self.split_horizontal_card_parameters
            {
              populate: {
                colorTheme: populate_fields("name"),
                bkColor: populate_fields("name"),
                image: image_params
              }
            }
          end

          def self.text_block_parameters
            {
              populate: {
                fields: "textContent",
                backgroundColor: populate_fields("name")
              }
            }
          end

          def self.question_and_answer_parameters
            {
              populate: {
                fields: ["question", "answer"],
                asideSections: populate_fields("slug"),
                answerIcons: icon_block_parameters
              }
            }
          end

          def self.full_width_banner_parameters
            {
              populate: {
                image: image_params,
                backgroundColor: populate_fields("name"),
                buttons: {populate: [:title, :link]}
              }
            }
          end

          def self.icon_block_parameters
            {populate: {iconImage: "alternativeText"}}
          end

          def self.card_wrapper_parameters
            {
              populate: {
                bkColor: {fields: "name"},
                resourceCards: resource_card_parameters,
                pictureCards: picture_card_parameters,
                numericCards: {fields: [:textContent, :title]}
              }
            }
          end

          def self.resource_card_parameters
            {
              populate: {
                icon: [:alternativeText],
                colorTheme: [:name]
              }
            }
          end

          def self.picture_card_parameters
            {
              populate: {
                image: [:alternativeText],
                colorTheme: [:name]
              }
            }
          end

          def self.testimonial_row_parameters
            {
              populate: {
                backgroundColor: populate_fields("name"),
                testimonials: testimonial_parameters
              }
            }
          end

          def self.testimonial_parameters
            {populate: {avatar: [:alternativeText]}}
          end

          def self.numbered_icon_list_parameters
            {
              populate: {
                titleIcon: image_params,
                asideSections: populate_fields("slug"),
                points: {
                  populate: {fields: [:textContent]}
                }
              }
            }
          end

          def self.community_activity_list_parameters = populate_fields([:title, :intro, :programmeActivityGroupSlug])

          def self.sticky_dashboard_bar_parameters = populate_fields([:programmeSlug])

          def self.enrolment_testimonial_parameters
            {
              populate: {
                fields: [:title],
                testimonial: testimonial_parameters,
                enrolledAside: populate_fields("slug"),
                bkColor: populate_fields("name")
              }
            }
          end

          def self.image_params
            {populate: [:alternativeText]}
          end

          def self.content_block_text_block = populate_fields([:textContent])

          def self.content_block_file_link
            {
              populate: {
                file: {populate: {fields: [:alternativeText]}}
              }
            }
          end

          def self.content_block_linked_picture
            {
              populate: {
                fields: [:link],
                image: {populate: {fields: [:alternativeText]}}
              }
            }
          end

          def self.populate_fields(fields)
            {populate: {fields:}}
          end
        end
      end
    end
  end
end
