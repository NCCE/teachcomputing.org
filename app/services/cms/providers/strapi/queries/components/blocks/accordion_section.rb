module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          module Blocks
            class AccordionSection < BaseComponentQuery
              def self.name = "ComponentBlocksAccordionSection"

              def self.base_fields
                <<~GRAPHQL.freeze
                  id
                  title
                  #{SharedFields.color_theme(:bkColor)}
                  #{ContentBlocks::AccordionBlock.embed(:accordionBlocks)}
                GRAPHQL
              end
            end
          end
        end
      end
    end
  end
end
