module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          module Blocks
            class IBelongPictureCardSection < BaseComponentQuery
              def self.name = "ComponentBlocksIBelongPictureCardSection"

              def self.base_fields
                <<~GRAPHQL.freeze
                  ibc__sectionTitle: sectionTitle
                  #{ContentBlocks::IBelongPictureCard.embed(:iBelongCards)}
                GRAPHQL
              end
            end
          end
        end
      end
    end
  end
end
