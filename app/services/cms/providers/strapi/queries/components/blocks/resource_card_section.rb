module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          module Blocks
            class ResourceCardSection < BaseComponentQuery
              def self.name = "ComponentBlocksResourceCardSection"

              def self.base_fields
                <<~GRAPHQL.freeze
                  #{ContentBlocks::ResourceCard.embed(:resourceCards)}
                  sectionTitle
                  cardsPerRow
                  #{SharedFields.color_theme(:bkColor)}
                  subText
                GRAPHQL
              end
            end
          end
        end
      end
    end
  end
end
