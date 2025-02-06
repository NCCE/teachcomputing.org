module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          module ContentBlocks
            class NumericCard < BaseComponentQuery
              def self.name = "ComponentContentBlocksNumericCard"

              def self.base_fields
                <<~GRAPHQL.freeze
                  title
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
