module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          module ContentBlocks
            class AccordionBlock < BaseComponentQuery
              def self.name = "ComponentContentBlocksAccordionBlock"

              def self.base_fields
                <<~GRAPHQL.freeze
                  heading
                  summaryText
                  textContent
                GRAPHQL
              end
            end
          end
        end
      end
    end
  end
end
