module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          module Blocks
            class HorizontalCard < BaseComponentQuery
              def self.name = "ComponentBlocksHorizontalCard"

              def self.base_fields
                <<~GRAPHQL.freeze
                  hozcard__title: title
                  hozcar__textContent: textContent
                  imageLink
                  externalTitle
                  spacing
                GRAPHQL
              end
            end
          end
        end
      end
    end
  end
end
