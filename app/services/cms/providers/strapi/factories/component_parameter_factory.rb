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
                colourTheme: {populate: {fields: "name"}},
                image: {populate: [:alternativeText]}
              }
            }
          end

          def self.text_block_parameters
            {
              populate: {
                fields: "content",
                backgroundColour: {populate: {fields: "name"}}
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
                backgroundColour: {populate: [:name]},
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
                bkColour: {fields: "name"},
                resourceCard: resource_card_parameters,
                pictureCard: picture_card_parameters
              }
            }
          end

          def self.resource_card_parameters
            {
              populate: {
                icon: [:alternativeText],
                colourTheme: [:name]
              }
            }
          end

          def self.picture_card_parameters
            {
              populate: {
                image: [:alternativeText],
                colourTheme: [:name]
              }
            }
          end
        end
      end
    end
  end
end
