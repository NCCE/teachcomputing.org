module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          module Blocks
            class PictureCardSection < BaseComponentQuery
              def self.name = "ComponentBlocksPictureCardSection"

              def self.base_fields
                <<~GRAPHQL.freeze
                  sectionTitle
                  cardsPerRow
                  #{SharedFields.color_theme(:bkColor)}
                  #{ContentBlocks::PictureCard.embed(:pictureCards)}
                GRAPHQL
              end
            end
          end
        end
      end
    end
  end
end
