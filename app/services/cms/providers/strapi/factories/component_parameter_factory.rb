module Cms
  module Providers
    module Strapi
      module Factories
        module ComponentParameterFactory
          def self.text_with_asides_paramters
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
                iconBlock: {populate: {iconImage: "alternativeText"}},
                colourTheme: {populate: {fields: "name"}},
                image: {populate: [:alternativeText]}
              }
            }
          end

          def self.text_block_parameters
            {
              populate: {fields: "content"}
            }
          end
        end
      end
    end
  end
end
