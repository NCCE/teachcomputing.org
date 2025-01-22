module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          module Blocks
            class NumericCardsSection < BaseComponentQuery
              def self.name = "ComponentBlocksNumericCardsSection"

              def self.base_fields
                <<~GRAPHQL.freeze
                  sectionTitle
                  #{ContentBlocks::NumericCard.embed(:numericCards)}
                  cardsPerRow
                  #{SharedFields.color_theme(:bkColor)}
                GRAPHQL
              end
            end
          end
        end
      end
    end
  end
end
