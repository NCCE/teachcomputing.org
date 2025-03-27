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
                  title
                  #{SharedFields.color_theme(:bkColor)}
                  #{ContentBlocks::AccordionBlock.embed(:accordionBlock)}
                GRAPHQL
              end
            end
          end
        end
      end
    end
  end
end
