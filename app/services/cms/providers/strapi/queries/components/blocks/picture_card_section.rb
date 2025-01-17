module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          module Blocks
            class PictureCardSection < BaseComponentQuery
              def self.fields
                super("ComponentBlocksPictureCardSection",
                  <<~GRAPHQL.freeze
                    sectionTitle
                    cardsPerRow
                    #{SharedFields.color_theme(:bkColor)}
                    pictureCards {
                      #{SharedFields.image_fields(:image)}
                      title
                      link
                      textContent
                      #{SharedFields.color_theme(:colorTheme)}
                    }
                  GRAPHQL
                )
              end
            end
          end
        end
      end
    end
  end
end
