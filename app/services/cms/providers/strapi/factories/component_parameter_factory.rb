module Cms
  module Providers
    module Strapi
      module Factories
        module ComponentParameterFactory
          def self.text_with_asides_parameters
            {
              populate: {
                fields: ["textContent"],
                asideSections: {populate: {fields: "slug"}}
              }
            }
          end

          def self.horizontal_card_parameters
            {
              populate: {
                iconBlock: icon_block_parameters,
                colorTheme: {populate: {fields: "name"}},
                image: {populate: [:alternativeText]}
              }
            }
          end

          def self.text_block_parameters
            {
              populate: {
                fields: "textContent",
                backgroundColor: {populate: {fields: "name"}}
              }
            }
          end

          def self.question_and_answer_parameters
            {
              populate: {
                fields: ["question", "answer"],
                asideSections: {populate: {fields: "slug"}},
                answerIcons: icon_block_parameters
              }
            }
          end

          def self.full_width_banner_parameters
            {
              populate: {
                image: {populate: [:alternativeText]},
                backgroundColor: {populate: [:name]},
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
                backgroundColour: [:name],
                testimonials: {
                  populate: {
                    avatar: [:alternativeText]
                  }
                }
              }
            }
          end
        end
      end
    end
  end
end
