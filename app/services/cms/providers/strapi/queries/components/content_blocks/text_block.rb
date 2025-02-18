module Cms
  module Providers
    module Strapi
      module Queries
        module Components
          module ContentBlocks
            class TextBlock < BaseComponentQuery
              def self.name = "ComponentContentBlocksTextBlock"

              def self.base_fields
                <<~GRAPHQL.freeze
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
