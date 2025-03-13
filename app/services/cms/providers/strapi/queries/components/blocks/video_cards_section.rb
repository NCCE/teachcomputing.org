module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          module Blocks
            class VideoCardsSection < BaseComponentQuery
              def self.name = "ComponentBlocksVideoCardsSection"

              def self.base_fields
                <<~GRAPHQL.freeze
                  title
                  introText
                  #{ContentBlocks::VideoCard.embed(:videoCards)}
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
